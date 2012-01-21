require 'spec_helper'

describe RegistrationsController do
  describe "routing" do
    it "routes GET '/sign_up' to 'registrations#new'" do
      get('/sign_up').should route_to("registrations#new")
    end

    it "routes POST '/sign_up' to 'registrations#create'" do
      post('/sign_up').should route_to("registrations#create")
    end

    it "routes GET '/profile' to 'registrations#edit'" do
      get('/profile').should route_to("registrations#edit")
    end

    it "routes PUT '/sign_up' to 'registrations#update'" do
      put('/sign_up').should route_to("registrations#update")
    end
  end
end
