require 'spec_helper'

describe RoomTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/hotels/1/room_types").should route_to("room_types#index", :hotel_id => '1')
    end

    it "routes to #new" do
      get("/hotels/1/room_types/new").should route_to("room_types#new", :hotel_id => '1')
    end

    it "routes to #show" do
      get("/hotels/1/room_types/1").should route_to("room_types#show", :id => "1", :hotel_id => '1')
    end

    it "routes to #edit" do
      get("/hotels/1/room_types/1/edit").should route_to("room_types#edit", :id => "1", :hotel_id => '1')
    end

    it "routes to #create" do
      post("/hotels/1/room_types").should route_to("room_types#create", :hotel_id => '1')
    end

    it "routes to #update" do
      put("/hotels/1/room_types/1").should route_to("room_types#update", :id => "1", :hotel_id => '1')
    end

    it "routes to #destroy" do
      delete("/hotels/1/room_types/1").should route_to("room_types#destroy", :id => "1", :hotel_id => '1')
    end

  end
end
