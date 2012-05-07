require "spec_helper"

describe CheckInsController do
  describe "routing" do

    it "routes GET '/rooms/1/check_ins to #index" do
      get("/rooms/1/check_ins").should route_to("check_ins#index", :room_id => "1")
    end

    it "routes GET '/rooms/1/check_ins/new' to #new" do
      get("/rooms/1/check_ins/new").should route_to("check_ins#new", :room_id => "1")
    end

    it "routes GET '/rooms/1/check_ins/1' to #show" do
      get("/rooms/1/check_ins/1").should route_to("check_ins#show", :id => "1", :room_id => "1")
    end

    it "routes GET '/rooms/1/check_ins/1/edit' to #edit" do
      get("/rooms/1/check_ins/1/edit").should route_to("check_ins#edit", :id => "1", :room_id => "1")
    end

    it "routes POST '/rooms/1/check_ins' to #create" do
      post("/rooms/1/check_ins").should route_to("check_ins#create", :room_id => "1")
    end

    it "routes PUT '/rooms/1/check_ins/1' to #update" do
      put("/rooms/1/check_ins/1").should route_to("check_ins#update", :id => "1", :room_id => "1")
    end

    it "routes DELETE '/rooms/1/check_ins/1' to #destroy" do
      delete("/rooms/1/check_ins/1").should route_to("check_ins#destroy", :id => "1", :room_id => "1")
    end

  end
end
