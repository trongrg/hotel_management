require 'spec_helper'

describe Room do
  before do
    @room_type = RoomType.make!
  end
  subject do
    @room_type.rooms.make!
  end
  it { should validate_presence_of :number }
  it { should validate_presence_of :room_type }
  it { should belong_to :room_type }
  it { should have_many :check_ins }
  it { should have_many :check_outs }
  describe "#current_check_in" do
    it "returns the only active check in" do
      expired_check_ins = (1..2).map { CheckIn.make!(:room => subject, :status => "Expired")}
      active_check_in = CheckIn.make!(:room => subject, :status => "Active")
      subject.reload.current_check_in.should == active_check_in
    end
  end
end
