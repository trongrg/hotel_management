require 'spec_helper'

describe Room do
  it { should belong_to :room_type }
  it { should have_one :hotel }
  it { should validate_presence_of :name }
  it { should validate_presence_of :room_type }
end
