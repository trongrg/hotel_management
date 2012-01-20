require 'spec_helper'

describe SessionsController do
  describe "routing" do
    it "routes GET '/sign_up' to 'devise/registrations#new'" do
      get('/sign_up').should route_to("devise/registrations#new")
    end

    it "routes GET '/sign_in' to 'sessions#create'" do
      get('/sign_in').should route_to("sessions#new")
    end

    it "routes GET '/sign_out' to 'sessions#create'" do
      get('/sign_out').should route_to("sessions#destroy")
    end
  end
end
