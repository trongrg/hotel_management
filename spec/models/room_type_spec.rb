require 'spec_helper'

describe RoomType do
  subject { RoomType.make }

  describe "mass assignment" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :price_attributes }
    it { should allow_mass_assignment_of :hotel_id }
  end

  describe "associations" do
    it { should belong_to :hotel }
    it { should have_many :rooms }
    # it { should have_many :furnishings }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :price_cents }
    it { should validate_presence_of :currency }
  end

  describe "callbacks" do
    describe "initialize" do
      context "without price" do
        before { subject.price_cents = nil }

        it "triggers initialize_price" do
          subject.should_receive(:initialize_price)
          subject.run_callbacks(:initialize)
        end
      end
    end
  end

  describe "#initialize_price" do
    it "initialize a money object as price" do
      subject.send(:initialize_price)
      subject.price.should be_present
      subject.price.should be_a(Money)
      subject.price_cents.should == 0
    end
  end

  describe "#price_attributes=" do
    before do
      attrs = {:dollars => 23.99, :currency => "USD"}
      subject.price_attributes = attrs
    end

    it "assigns attributes to price" do
      subject.price.should == Money.new(2399)
    end
  end
end
