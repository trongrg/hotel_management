require 'spec_helper'

describe DashboardController do
  describe "routing" do
    it "routes GET '/dashboard' to dashboard#show" do
      get("/dashboard").should route_to("dashboard#show")
    end
  end
end
