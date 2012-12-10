require "spec_helper"

describe HotelsController do
  describe "routing" do
    it "routes get '/hotels' to hotels#index" do
      get("/hotels").should route_to("hotels#index")
    end

    it "routes get 'hotels/new' to hotels#new" do
      get("/hotels/new").should route_to("hotels#new")
    end

    it "routes get 'hotels/1' to hotels#show" do
      get("/hotels/1").should route_to("hotels#show", :id => "1")
    end

    it "routes get 'hotels/1/edit' to hotels#edit" do
      get("/hotels/1/edit").should route_to("hotels#edit", :id => "1")
    end

    it "routes post 'hotels' to hotels#create" do
      post("/hotels").should route_to("hotels#create")
    end

    it "routes put 'hotels/1' to hotels#update" do
      put("/hotels/1").should route_to("hotels#update", :id => "1")
    end

    it "routes delete 'hotels/1' to hotels#destroy" do
      delete("/hotels/1").should route_to("hotels#destroy", :id => "1")
    end
  end
end
