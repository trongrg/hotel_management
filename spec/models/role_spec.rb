require 'spec_helper'

describe Role do
  before do
    Role.create(:name => "Admin")
  end
  it { should have_and_belong_to_many :users }
  it { should validate_uniqueness_of :name }
end
