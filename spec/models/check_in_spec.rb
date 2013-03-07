require 'spec_helper'

describe CheckIn do
  subject { CheckIn.make }

  describe "mass assignment" do
    it { should allow_mass_assignment_of :adults }
    it { should allow_mass_assignment_of :children }
    it { should allow_mass_assignment_of :prepaid_attributes }
    it { should allow_mass_assignment_of :guest_attributes }
    it { should allow_mass_assignment_of :status }
    it { should allow_mass_assignment_of :special_request }
    it { should allow_mass_assignment_of :room_ids }
  end

  describe "associations" do
    it { should belong_to :guest }
    it { should belong_to :hotel }
    it { should have_and_belong_to_many :rooms }
  end

  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :hotel }
    it { should validate_presence_of :rooms }
    it { should validate_presence_of :guest }
    it { should ensure_inclusion_of(:status).in_array(CheckIn::STATUSES.values) }

    it "should require all rooms to be avaiable" do
      subject.should_receive(:rooms_availability)
      subject.run_callbacks(:validate)
    end
  end

  describe "callbacks" do
    describe "initialize" do
      context "without status" do
        before { subject.status = nil }

        it "triggers set_default_status after initialized" do
          subject.should_receive(:set_default_status)
          subject.run_callbacks(:initialize)
        end
      end

      context "without guest" do
        before { subject.guest = nil }

        it "triggers build_guest after initialized" do
          subject.should_receive(:build_guest)
          subject.run_callbacks(:initialize)
        end
      end
    end

    describe "save" do
      it "triggers update_rooms_availability" do
        subject.should_receive(:update_rooms_availability)
        subject.run_callbacks(:save)
      end
    end
  end

  describe "scopes" do
    let(:check_ins) { CheckIn::STATUSES.inject({}) { |hash, array| hash.update(array[0] => CheckIn.make!(:status => array[1])) } }
    CheckIn::STATUSES.keys.each do |status|
      describe ".#{status.to_s}" do
        it "includes check ins with #{status.to_s} status" do
          CheckIn.send(status).should include(check_ins[status])
        end

        it "excludes check ins with other status" do
          CheckIn::STATUSES.except(status).keys.each do |excluded_status|
            CheckIn.send(status).should_not include(check_ins[excluded_status])
          end
        end
      end
    end

    describe ".status" do
      context "with valid status" do
        it "returns check in with corresponding status" do
          CheckIn.status("active").should == [check_ins[:active]]
          CheckIn.status("expired").should == [check_ins[:expired]]
        end
      end

      context "with invalid status" do
        it "returns all check ins" do
          CheckIn.status(nil).should == CheckIn.all
          CheckIn.status("invalid").should == CheckIn.all
        end
      end
    end
  end

  describe "#rooms_availability" do
    context "some rooms are not available" do
      before { Room.any_instance.stub(:available?).and_return false }

      it "returns false" do
        subject.send(:rooms_availability).should be_false
      end

      it "adds error to base" do
        subject.send(:rooms_availability)
        subject.errors[:base].should include I18n.t('activerecord.errors.models.check_in.attributes.base.not_available')
      end
    end
  end

  describe "#set_default_status" do
    it "sets default status to Active" do
      subject.send(:set_default_status)
      subject.status.should == CheckIn::STATUSES[:active]
    end
  end

  describe "#update_rooms_availability" do
    context "active" do
      before { subject.status = CheckIn::STATUSES[:active] }

      it "make all rooms unavailable" do
        subject.send(:update_rooms_availability)
        subject.rooms.any? { |r| r.available? }.should be_true
      end
    end

    context "expired" do
      before { subject.status = CheckIn::STATUSES[:active] }

      it "make all rooms available" do
        subject.send(:update_rooms_availability)
        subject.rooms.all? { |r| r.available? }.should be_true
      end
    end
  end
end
