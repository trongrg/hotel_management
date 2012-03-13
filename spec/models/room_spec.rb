require 'spec_helper'

describe Room do
  it { should validate_presence_of :number }
  it { should validate_presence_of :room_type }
  it { should belong_to :room_type }
end
