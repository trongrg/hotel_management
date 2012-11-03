require 'spec_helper'

describe Room do
  subject do
    room_type = RoomType.make!
    room_type.rooms.make!
  end

  it { should validate_presence_of :number }
  it { should validate_presence_of :room_type }
  it { should belong_to :room_type }
  it { should have_many :check_ins }
  it { should have_many :check_outs }

  describe "#current_check_in" do
    it "returns the only active check in" do
      expired_check_ins = (1..2).map { subject.check_ins.make!(:room => subject, :status => "Expired")}
      active_check_in = subject.check_ins.make!(:room => subject, :status => "Active")
      subject.reload.current_check_in.should == active_check_in
    end
  end

  describe "#occupied?" do
    context "has current check in" do
      before do
        active_check_in = subject.check_ins.make!(:room => subject, :status => "Active")
      end
      it "returns true" do
        subject.reload.should be_occupied
      end
    end

    context "does not have current check in" do
      it "returns false" do
        subject.should_not be_occupied
      end
    end
  end
end
