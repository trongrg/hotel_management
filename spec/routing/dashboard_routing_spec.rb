require 'spec_helper'

describe DashboardController do
  describe "routing" do
    it "routes GET '/dashboard' to dashboard#index" do
      get("/").should route_to("dashboard#index")
    end
  end
end
