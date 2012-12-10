require 'spec_helper'

describe Location do
  subject { Location.new }
  it { should belong_to :locatable }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }

  describe "#all_blank?" do
    context "all attributes are blank" do
      it "returns true" do
        subject.should be_all_blank
      end
    end
    context "with a attribute" do
      it "return false" do
        [:latitude, :longitude].each do |attr|
          location = Location.new
          location.send("#{attr}=", 123)
          location.should_not be_all_blank
        end
      end
    end
  end
end
