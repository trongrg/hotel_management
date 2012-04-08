require 'spec_helper'

describe HotelsUser do
  it { should belong_to :user }
  it { should belong_to :hotel }
end
