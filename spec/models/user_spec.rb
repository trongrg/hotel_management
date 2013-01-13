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
  it { should have_one :address }
  it { should have_many :hotels }
  it { should have_many :room_types }
  it { should have_and_belong_to_many :working_hotels }

  describe "#full_name" do
    it "returns the full_name of user" do
      subject.full_name.should == subject.first_name + " " + subject.last_name
    end
  end

  describe "#remove_empty_address" do
    context "address is not null and all blank" do
      before do
        subject.save!
        subject.build_address.save(:validate => false)
      end

      it "destroys the address" do
        subject.address.should_receive(:destroy).and_return true
        subject.send(:remove_emtpy_address)
      end
    end
    context "address is null" do
      it "does nothing" do
        allow_message_expectations_on_nil
        subject.address.should_not_receive(:destroy)
        subject.send(:remove_emtpy_address)
      end
    end
    context "address has some value" do
      it "does nothing" do
        subject.address = Address.new(:line1 => "test")
        subject.address.should_not_receive(:destroy)
        subject.send(:remove_emtpy_address)
      end
    end
  end
end
