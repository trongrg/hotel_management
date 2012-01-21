require 'spec_helper'

describe User do
  subject { User.make }
  it { should validate_presence_of :username }
  it { should validate_presence_of :dob }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_and_belong_to_many :roles }

  it "validates confirmation of password" do
    subject.password_confirmation = "123"
    subject.password = "123456"
    subject.save.should be_false
    subject.errors.should include :password
    subject.errors[:password].should include "doesn't match confirmation"
  end

  describe "validates username" do
    context "with valid username" do
      it "saves the user" do
        subject.username = "username"
        subject.save.should be_true
      end
    end
    context "with invalid username" do
      let(:usernames) { ["user name", "user^$", "user?"] }
        it "does not save the user and has correct error message" do
          usernames.each do |username|
            subject.username = username
            subject.save.should be_false
            subject.errors.should include :username
            subject.errors[:username].should include "is invalid. Only letters, digits, periods and underscores are allowed."
          end
        end
    end
  end
end
