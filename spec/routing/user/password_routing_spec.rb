describe Users::PasswordController do
  describe "routing" do
    it "routes get '/profile/password' to users/password#edit" do
      get('/profile/password').should route_to "users/password#edit"
    end

    it "routes put '/profile/password' to users/password#update" do
      put('/profile/password').should route_to "users/password#update"
    end
  end
end
