require 'spec_helper'

describe User do
  subject { User.make }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_confirmation_of :password }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :date_of_birth }
  it { should ensure_inclusion_of(:gender).in_array(["Male", "Female"])}
  it { should validate_presence_of :roles }

  describe "#full_name" do
    it "returns the full_name of user" do
      subject.full_name.should == subject.first_name + " " + subject.last_name
    end
  end
end
