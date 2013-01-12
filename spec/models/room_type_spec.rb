require 'spec_helper'

describe RoomType do
  subject { RoomType.make }
  it { should validate_presence_of :name }
  it { should validate_presence_of :price_cents }
  it { should validate_presence_of :currency }

  it { should belong_to :hotel }
  it { should have_many :rooms }
  # it { should have_many :furnishings }

  describe "#initialize_price" do
    context "blank price" do
      before do
        subject.price_cents = nil
        subject.send(:initialize_price)
      end

      it "initialize a money object as price" do
        subject.price.should be_present
        subject.price.should be_a(Money)
        subject.price_cents.should == 0
      end
    end

    context "existing price" do
      it "does nothing" do
        subject.price.should_not == Money.new(0)
      end
    end
  end

  describe "after_initialize" do
    it "triggers initialize_price" do
      room_type = RoomType.allocate
      room_type.should_receive(:initialize_price)
      room_type.run_callbacks(:initialize)
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
