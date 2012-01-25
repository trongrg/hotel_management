require 'spec_helper'

describe RoomType do
  it { should validate_presence_of :name }
  it { should validate_presence_of :price }
  it { should validate_presence_of :currency }

  it { should belong_to :hotel }
end
