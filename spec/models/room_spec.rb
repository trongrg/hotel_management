require 'spec_helper'

describe Room do
  describe "mass assignment" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :room_type_id }
  end

  describe "associations" do
    it { should belong_to :room_type }
    it { should have_one :hotel }
    it { should have_and_belong_to_many :reservations }
    it { should have_and_belong_to_many :check_ins }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :room_type }
  end

  describe "#current_check_in" do
    it "returns the active check_in" do
      room = Room.make!
      2.times { CheckIn.make!(:rooms => [room], :status => CheckIn::STATUSES[:expired]) }
      current_check_in = CheckIn.make!(:rooms => [room], :status => CheckIn::STATUSES[:active])
      room.current_check_in.should == current_check_in
    end
  end
end
