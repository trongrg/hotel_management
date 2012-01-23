require 'spec_helper'

describe Hotel do
  it { should validate_presence_of :name }
  it { should validate_presence_of :phone_number }
  it { should validate_presence_of :lat }
  it { should validate_presence_of :lng }
  it { should belong_to :owner }
end
