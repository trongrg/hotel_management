require "spec_helper"

describe CheckInsController do
  describe "routing" do

    it "routes GET '/hotels/1/check_ins to #index" do
      get("/hotels/1/check_ins").should route_to("check_ins#index", :hotel_id => "1")
    end

    it "routes GET '/hotels/1/check_ins/new' to #new" do
      get("/hotels/1/check_ins/new").should route_to("check_ins#new", :hotel_id => "1")
    end

    it "routes GET '/hotels/1/check_ins/1' to #show" do
      get("/hotels/1/check_ins/1").should route_to("check_ins#show", :id => "1", :hotel_id => "1")
    end

    it "routes GET '/hotels/1/check_ins/1/edit' to #edit" do
      get("/hotels/1/check_ins/1/edit").should route_to("check_ins#edit", :id => "1", :hotel_id => "1")
    end

    it "routes POST '/hotels/1/check_ins' to #create" do
      post("/hotels/1/check_ins").should route_to("check_ins#create", :hotel_id => "1")
    end

    it "routes PUT '/hotels/1/check_ins/1' to #update" do
      put("/hotels/1/check_ins/1").should route_to("check_ins#update", :id => "1", :hotel_id => "1")
    end

    it "routes DELETE '/hotels/1/check_ins/1' to #destroy" do
      delete("/hotels/1/check_ins/1").should route_to("check_ins#destroy", :id => "1", :hotel_id => "1")
    end

  end
end
