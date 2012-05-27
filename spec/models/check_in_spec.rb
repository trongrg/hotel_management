require 'spec_helper'

describe CheckIn do
  subject do
    CheckIn.make
  end
  it { should belong_to :user }
  it { should belong_to :guest }
  it { should belong_to :room }
  it { should validate_presence_of :status }
  it { should validate_presence_of :room }
  it { should validate_presence_of :guest }
  it { should validate_presence_of :user }

  it "sets default status to Active" do
    CheckIn.new.status.should == "Active"
  end

  it "sets default guest to a new Guest" do
    CheckIn.new.guest.should be_a_new Guest
  end

  context "status is not Active" do
    before do
      subject.update_attribute(:status, CheckIn::STATUS[:expired])
    end
    context "update" do
      it "does not update" do
        subject.update_attributes(:status => CheckIn::STATUS[:active]).should be_false
        subject.update_attribute(:status, CheckIn::STATUS[:active]).should be_false
      end
      it "adds errors to base" do
        subject.update_attributes(:status => CheckIn::STATUS[:active])
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

  it "does not belong to a occupied room" do
    room = Room.make!(:room_type => RoomType.make)
    CheckIn.make!(:room => room, :status => CheckIn::STATUS[:active])
    room.reload
    check_in = CheckIn.make(:room => room, :status => CheckIn::STATUS[:active])
    check_in.save
    check_in.should_not be_persisted
    check_in.errors[:base].should include("Cannot check in to an occupied room")
  end
end
