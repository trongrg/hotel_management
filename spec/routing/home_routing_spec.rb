describe HomeController do
  describe "routing" do
    it "route get '/' to home#index" do
      get('/').should route_to "home#index"
    end
  end
end
