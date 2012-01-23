require "spec_helper"

describe HotelsController do
  describe "routing" do

    it "routes to #index" do
      get("/users/1/hotels").should route_to("hotels#index", :user_id => '1')
    end

    it "routes to #new" do
      get("/users/1/hotels/new").should route_to("hotels#new", :user_id => '1')
    end

    it "routes to #show" do
      get("/users/1/hotels/1").should route_to("hotels#show", :id => "1", :user_id => '1')
    end

    it "routes to #edit" do
      get("/users/1/hotels/1/edit").should route_to("hotels#edit", :id => "1", :user_id => '1')
    end

    it "routes to #create" do
      post("/users/1/hotels").should route_to("hotels#create", :user_id => '1')
    end

    it "routes to #update" do
      put("/users/1/hotels/1").should route_to("hotels#update", :id => "1", :user_id => '1')
    end

    it "routes to #destroy" do
      delete("/users/1/hotels/1").should route_to("hotels#destroy", :id => "1", :user_id => '1')
    end

  end
end
