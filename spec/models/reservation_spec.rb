require 'spec_helper'

describe Reservation do
  subject { Reservation.make }
  it { should belong_to :guest }
  it { should belong_to :hotel }
  it { should have_and_belong_to_many :rooms }
  it { should validate_presence_of :hotel }
  it { should validate_presence_of :guest }
  it { should validate_presence_of :status }
  it { should validate_presence_of :check_in_date }
  it { should ensure_inclusion_of(:status).in_array(Reservation::STATUSES.values) }

  describe "#set_default_status" do
    it "sets default status to Active" do
      subject.send(:set_default_status)
      subject.status.should == "Active"
    end
  end

  describe "initialize" do
    it "triggers set_default_status" do
      subject.should_receive(:set_default_status)
      subject.run_callbacks(:initialize)
    end

    it "triggers build_guest" do
      subject.should_receive(:build_guest)
      subject.guest = nil
      subject.run_callbacks(:initialize)
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
