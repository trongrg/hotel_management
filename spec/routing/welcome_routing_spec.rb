require 'spec_helper'

describe WelcomeController do
  describe "routing" do
    it "routes GET '/' to welcome#show" do
      get("/").should route_to("welcome#show")
    end
  end
end
