require "spec_helper"

describe CheckOutsController do
  describe "routing" do

    it "routes GET '/rooms/1/check_outs to #index" do
      get("/rooms/1/check_outs").should route_to("check_outs#index", :room_id => "1")
    end

    it "routes GET '/rooms/1/check_outs/new' to #new" do
      get("/rooms/1/check_outs/new").should route_to("check_outs#new", :room_id => "1")
    end

    it "routes GET '/rooms/1/check_outs/1' to #show" do
      get("/rooms/1/check_outs/1").should route_to("check_outs#show", :id => "1", :room_id => "1")
    end

    it "routes GET '/rooms/1/check_outs/1/edit' to #edit" do
      get("/rooms/1/check_outs/1/edit").should route_to("check_outs#edit", :id => "1", :room_id => "1")
    end

    it "routes POST '/rooms/1/check_outs' to #create" do
      post("/rooms/1/check_outs").should route_to("check_outs#create", :room_id => "1")
    end

    it "routes PUT '/rooms/1/check_outs/1' to #update" do
      put("/rooms/1/check_outs/1").should route_to("check_outs#update", :id => "1", :room_id => "1")
    end

    it "routes DELETE '/rooms/1/check_outs/1' to #destroy" do
      delete("/rooms/1/check_outs/1").should route_to("check_outs#destroy", :id => "1", :room_id => "1")
    end

  end
end
