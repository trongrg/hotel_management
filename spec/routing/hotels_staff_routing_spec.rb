describe StaffController do
  describe "routing" do
    it "routes GET '/hotels/1/staff' to staff#index" do
      get('/hotels/1/staff').should route_to("staff#index", :hotel_id => "1")
    end

    it "routes GET '/hotels/1/staff/1' to staff#show" do
      get('/hotels/1/staff/1').should route_to("staff#show", :hotel_id => "1", :id => "1")
    end

    it "routes DELETE '/hotels/1/staff/1' to staff#destroy" do
      delete('/hotels/1/staff/1').should route_to("staff#destroy", :hotel_id => "1", :id => "1")
    end
  end
end
