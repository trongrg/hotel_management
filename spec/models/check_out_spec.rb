require 'spec_helper'

describe CheckOut do
  before do
    @room_type = RoomType.make!(:price_in_cents => 12300)
    @room = Room.make!(:room_type => @room_type)
    @check_in = CheckIn.make!(:room => @room, :status => "Active")
    @check_in.update_attribute(:created_at, 2.days.ago.beginning_of_day + 8.hours)
    @room.reload
  end

  subject do
    CheckOut.create(:user => User.make, :guest => Guest.make, :room => @room)
  end
  it { should belong_to :user }
  it { should belong_to :guest }
  it { should belong_to :room }
  it { should belong_to :check_in }
  it { should validate_presence_of :user }
  it { should validate_presence_of :room }

  it "takes the room's current active check_in as its check in" do
    subject.check_in.should == @check_in
  end

  it "takes the room's current price as its room_price" do
    subject.room_price.format.should == "$123.00"
  end

  it "calculates the number of nights base on check_in date and created time" do
    Timecop.freeze(DateTime.now.beginning_of_day + 8.hours) do
      subject.nights.should == 2
    end
    Timecop.freeze(DateTime.now.beginning_of_day + 13.hours) do
      subject.save
      subject.nights.should == 3
    end
    Timecop.freeze(DateTime.now.end_of_day + 13.hours) do
      subject.save
      subject.nights.should == 4
    end
    Timecop.freeze(DateTime.now.end_of_day + 11.hours) do
      subject.save
      subject.nights.should == 3
    end
  end
end
