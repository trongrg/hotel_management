require 'spec_helper'

describe Reservation do
  subject { Reservation.make }

  describe "mass assignment" do
    it { should allow_mass_assignment_of :check_in_date }
    it { should allow_mass_assignment_of :check_out_date }
    it { should allow_mass_assignment_of :adults }
    it { should allow_mass_assignment_of :children }
    it { should allow_mass_assignment_of :special_request }
    it { should allow_mass_assignment_of :status }
    it { should allow_mass_assignment_of :room_ids }
    it { should allow_mass_assignment_of :hotel_id }
    it { should allow_mass_assignment_of :guest_attributes }
    it { should allow_mass_assignment_of :prepaid_attributes }
  end

  describe "associations" do
    it { should belong_to :guest }
    it { should belong_to :hotel }
    it { should have_and_belong_to_many :rooms }
  end

  describe "validations" do
    it { should validate_presence_of :hotel }
    it { should validate_presence_of :guest }
    it { should validate_presence_of :status }
    it { should validate_presence_of :check_in_date }
    it { should ensure_inclusion_of(:status).in_array(Reservation::STATUSES.values) }
  end

  describe "callbacks" do
    describe "initialize" do
      context "without status" do
        before { subject.status = nil }

        it "triggers set_default_status" do
          subject.should_receive(:set_default_status)
          subject.run_callbacks(:initialize)
        end
      end

      context "without guest" do
        before { subject.guest = nil }

        it "triggers build_guest" do
          subject.should_receive(:build_guest)
          subject.run_callbacks(:initialize)
        end
      end
    end
  end

  describe "#set_default_status" do
    it "sets default status to Active" do
      subject.send(:set_default_status)
      subject.status.should == "Active"
    end
  end

  describe "#prepaid_attributes=" do
    before do
      attrs = {:dollars => 23.99, :currency => "USD"}
      subject.prepaid_attributes = attrs
    end

    it "assigns attributes to price" do
      subject.prepaid.should == Money.new(2399)
    end
  end

  describe "scopes" do
    Reservation::STATUSES.keys.each do |status|
      describe ".#{status.to_s}" do
        let(:reservations) { reservations = Reservation::STATUSES.inject({}) { |hash, array| hash.update(array[0] => Reservation.make!(:status => array[1])) } }

        it "includes resevations with #{status.to_s} status" do
          Reservation.send(status).should include(reservations[status])
        end

        it "excludes reservations with other status" do
          Reservation::STATUSES.except(status).keys.each do |excluded_status|
            Reservation.send(status).should_not include(reservations[excluded_status])
          end
        end
      end
    end
  end
end
