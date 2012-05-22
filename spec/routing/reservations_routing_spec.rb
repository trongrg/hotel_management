require "spec_helper"

describe ReservationsController do
  describe "routing" do

    it "routes GET '/rooms/1/reservations' to #index" do
      get("/rooms/1/reservations").should route_to("reservations#index", :room_id => "1")
    end

    it "routes GET '/rooms/1/reservations/new' to #new" do
      get("/rooms/1/reservations/new").should route_to("reservations#new", :room_id => "1")
    end

    it "routes GET '/rooms/1/reservations/1' to #show" do
      get("/rooms/1/reservations/1").should route_to("reservations#show", :id => "1", :room_id => "1")
    end

    it "routes GET '/rooms/1/reservations/1/edit to #edit" do
      get("/rooms/1/reservations/1/edit").should route_to("reservations#edit", :id => "1", :room_id => "1")
    end

    it "routes POST '/rooms/1/reservations' to #create" do
      post("/rooms/1/reservations").should route_to("reservations#create", :room_id => "1")
    end

    it "routes PUT '/rooms/1/reservations/1' to #update" do
      put("/rooms/1/reservations/1").should route_to("reservations#update", :id => "1", :room_id => "1")
    end

    it "routes DELETE '/rooms/1/reservations/1' to #destroy" do
      delete("/rooms/1/reservations/1").should route_to("reservations#destroy", :id => "1", :room_id => "1")
    end

  end
end
