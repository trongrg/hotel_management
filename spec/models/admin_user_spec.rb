require 'spec_helper'

describe AdminUser do
  describe "ensure last admin" do
    before do
      AdminUser.make!
      AdminUser.make!
    end
    it "does not destroy last admin" do
      AdminUser.destroy_all
      AdminUser.count.should == 1
    end
  end
end
