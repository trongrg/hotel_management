require 'spec_helper'

describe Profile::PasswordController do
  describe "routing" do
    it "routes GET '/password' to 'profile/password#edit'" do
      get('/profile/password/edit').should route_to("profile/password#edit")
    end

    it "routes PUT '/password' to 'profile/password#update'" do
      put('/profile/password').should route_to("profile/password#update")
    end
  end
end
