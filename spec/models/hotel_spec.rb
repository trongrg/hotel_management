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
end
