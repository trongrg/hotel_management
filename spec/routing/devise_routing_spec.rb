require 'spec_helper'

describe Devise do
  describe "routing" do
    it "routes GET '/sign_up' to 'devise/sessions#new'" do
      get('/sign_up').should route_to("devise/registrations#new")
    end

    it "routes GET '/sign_in' to 'devise/sessions#create'" do
      get('/sign_in').should route_to("devise/sessions#new")
    end

    it "routes GET '/sign_out' to 'devise/sessions#create'" do
      get('/sign_out').should route_to("devise/sessions#destroy")
    end
  end
end
