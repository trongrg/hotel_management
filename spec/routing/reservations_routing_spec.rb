require "spec_helper"

describe ReservationsController do
  describe "routing" do

    it "routes get '/hotels/1/reservations' to #index" do
      get("/hotels/1/reservations").should route_to("reservations#index", :hotel_id => "1")
    end

    it "routes get '/hotels/1/reservations/new' to #new" do
      get("/hotels/1/reservations/new").should route_to("reservations#new", :hotel_id => "1")
    end

    it "routes get '/hotels/1/reservations/1' to #show" do
      get("/hotels/1/reservations/1").should route_to("reservations#show", :id => "1", :hotel_id => "1")
    end

    it "routes get '/hotels/1/reservations/1/edit' to #edit" do
      get("/hotels/1/reservations/1/edit").should route_to("reservations#edit", :id => "1", :hotel_id => "1")
    end

    it "routes post '/hotels/1/reservations' to #create" do
      post("/hotels/1/reservations").should route_to("reservations#create", :hotel_id => "1")
    end

    it "routes put '/hotels/1/reservations/1' to #update" do
      put("/hotels/1/reservations/1").should route_to("reservations#update", :id => "1", :hotel_id => "1")
    end

    it "routes delete '/hotels/1/reservations/1' to #destroy" do
      delete("/hotels/1/reservations/1").should route_to("reservations#destroy", :id => "1", :hotel_id => "1")
    end

  end
end


