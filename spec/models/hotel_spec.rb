require 'spec_helper'

describe Hotel do
  subject { Hotel.make }

  describe "mass assignment" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:phone) }
    it { should allow_mass_assignment_of(:address_attributes) }
    it { should allow_mass_assignment_of(:location_attributes) }
  end

  describe "associations" do
    it { should belong_to :owner }
    it { should have_one :address }
    it { should have_one :location }
    it { should have_many :room_types }
    it { should have_many :rooms }
    it { should have_many :reservations }
    it { should have_many :check_ins }
    it { should have_and_belong_to_many :staff_members }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :address }
    it { should validate_presence_of :owner }
    it { should validate_presence_of :location }
  end

  describe "callbacks" do
    describe "initialize" do
      context "without address" do
        before { subject.address = nil }

        it "triggers build_address" do
          subject.should_receive(:build_address)
          subject.run_callbacks(:initialize)
        end
      end

      context "without location" do
        before { subject.location = nil }

        it "triggers build_location" do
          subject.should_receive(:build_location)
          subject.run_callbacks(:initialize)
        end
      end
    end
  end
end
