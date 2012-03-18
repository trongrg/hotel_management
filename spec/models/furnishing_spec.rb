require 'spec_helper'

describe Furnishing do
  it { should belong_to :room_type }
  it { should validate_presence_of :room_type_id }
  it { should validate_presence_of :name }
  it { should validate_presence_of :price }
end
