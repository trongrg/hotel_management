require 'spec_helper'

describe Address do
  subject do
    Address.new
  end

  it { should validate_presence_of :address_1 }
  it { should validate_presence_of :city }
  it { should validate_presence_of :country }

  it "has VN as the default country" do
    subject.country.should == "VN"
  end

  describe "#to_string" do
    it "returns the full address" do
      subject.to_string.should == [subject.address_1, subject.address_2, subject.city, subject.state, subject.country, subject.zip_code].join(" ")
    end
  end

end
