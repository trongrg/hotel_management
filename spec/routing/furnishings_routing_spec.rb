require "spec_helper"

describe FurnishingsController do
  describe "routing" do

    it "routes to #index" do
      get("/room_types/1/furnishings").should route_to("furnishings#index", :room_type_id => "1")
    end

    it "routes to #new" do
      get("/room_types/1/furnishings/new").should route_to("furnishings#new", :room_type_id => "1")
    end

    it "routes to #show" do
      get("/room_types/1/furnishings/1").should route_to("furnishings#show", :id => "1", :room_type_id => "1")
    end

    it "routes to #edit" do
      get("/room_types/1/furnishings/1/edit").should route_to("furnishings#edit", :id => "1", :room_type_id => "1")
    end

    it "routes to #create" do
      post("/room_types/1/furnishings").should route_to("furnishings#create", :room_type_id => "1")
    end

    it "routes to #update" do
      put("/room_types/1/furnishings/1").should route_to("furnishings#update", :id => "1", :room_type_id => "1")
    end

    it "routes to #destroy" do
      delete("/room_types/1/furnishings/1").should route_to("furnishings#destroy", :id => "1", :room_type_id => "1")
    end

  end
end
