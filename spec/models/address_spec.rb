require 'spec_helper'

describe Address do
  subject { Address.new }
  it { should belong_to :addressable }
  it { should validate_presence_of :line1 }
  it { should validate_presence_of :city }
  it { should validate_presence_of :country }

  describe "#all_blank?" do
    context "all attributes are blank" do
      it "returns true" do
        subject.should be_all_blank
      end
    end
    context "with a attribute" do
      it "return false" do
        [:line1, :line2, :city, :state, :zip, :country].each do |attr|
          address = Address.new
          address.send("#{attr}=", "something")
          address.should_not be_all_blank
        end
      end
    end
  end
end
