require 'spec_helper'

describe Hotel do
  it { should validate_presence_of :name }
  it { should validate_presence_of :phone_number }
  it { should validate_presence_of :lat }
  it { should validate_presence_of :lng }
  it { should belong_to :owner }
  it { should have_many :room_types }
  it { should have_many :rooms }
  it { should have_many :staff_members }
  it { should have_many :hotels_staff_members }

  it "has VN as the default country" do
    hotel = Hotel.new
    hotel.country.should == "VN"
  end

  it "stores lat and lng correctly" do
    hotel = Hotel.make!
    hotel.update_attributes(:lat => -33.87893199620149, :lng => 151.1978550613769)
    hotel.reload
    hotel.lng.should == 151.1978550613769
    hotel.lat.should == -33.87893199620149
    hotel.update_attributes(:lat => -90, :lng => 180)
    hotel.reload
    hotel.lng.should == 180
    hotel.lat.should == -90
  end
end
