describe GeocoderController do
  describe "routing" do
    it "route get 'geocoder/get_location' to geocoder#get_location" do
      post('/geocoder/get_location').should route_to "geocoder#get_location"
    end
    it "route get 'geocoder/get_address' to geocoder#get_address" do
      post('/geocoder/get_address').should route_to "geocoder#get_address"
    end
  end
end
