require 'spec_helper'

describe Hotel do
  subject { Hotel.make }
  it { should have_and_belong_to_many :owners }
  it { should have_one :address }
  it { should have_one :location }
  it { should have_many :room_types }
  it { should validate_presence_of :name }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :address }
  it { should validate_presence_of :owners }
  it { should validate_presence_of :location }

  describe "#belongs_to?" do
    let(:user) { User.make }
    context "belongs to user" do
      it "returns true" do
        subject.owners << user
        subject.belongs_to?(user).should be_true
      end
    end
    context "is new record" do
      it "returns true" do
        subject.should be_a_new(Hotel)
        subject.belongs_to?(user).should be_true
      end
    end
  end
end
