require 'spec_helper'

describe Guest do
  subject { Guest.new }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should ensure_inclusion_of(:gender).in_array Guest::GENDERS}

  describe "#full_name" do
    it "returns the guest's full name" do
      subject.first_name = "Trong"
      subject.last_name = "Tran"
      subject.full_name.should == "Trong Tran"
    end
  end
end
