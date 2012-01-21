require 'spec_helper'

describe SessionsController do
  describe "routing" do
    it "routes GET '/sign_in' to 'sessions#create'" do
      get('/sign_in').should route_to("sessions#new")
    end

    it "routes POST '/sign_in' to 'sessions#create'" do
      post('/sign_in').should route_to("sessions#create")
    end

    it "routes GET '/sign_out' to 'sessions#create'" do
      get('/sign_out').should route_to("sessions#destroy")
    end
  end
end
