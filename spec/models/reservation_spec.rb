require 'spec_helper'

describe Reservation do
  subject do
    Reservation.make
  end
  it { should belong_to :room }
  it { should belong_to :user }
  it { should belong_to :guest }
  it { should validate_presence_of :room }
  it { should validate_presence_of :user }
  it { should validate_presence_of :guest }
  it { should validate_presence_of :status }
  it { should validate_presence_of :check_in_date }
  it { should validate_presence_of :check_out_date }

  it "sets default status to Active" do
    Reservation.new.status.should == "Active"
  end

  it "sets default guest to a new Guest" do
    Reservation.new.guest.should be_a_new Guest
  end

  context "status is Expired" do
    before do
      subject.update_attribute(:status, Reservation::STATUS[:expired])
    end
    context "update" do
      it "does not update" do
        subject.update_attributes(:status => Reservation::STATUS[:active]).should be_false
        subject.update_attribute(:status, Reservation::STATUS[:active]).should be_false
      end
      it "adds errors to base" do
        subject.update_attributes(:status => Reservation::STATUS[:active])
        subject.errors[:base].should include("Cannot edit/delete expired check in")
      end
    end
    context "destroy" do
      it "does not destroy" do
        subject.destroy.should be_false
      end
      it "adds errors to base" do
        subject.destroy
        subject.errors[:base].should include("Cannot edit/delete expired check in")
      end
    end
  end

  describe "#expired?" do
    it "returns whether the status is 'Expired' or not" do
      subject.update_attributes(:status => Reservation::STATUS[:expired])
      subject.expired?.should be_true
    end
  end
end
