describe "user reset password" do
  describe "routing" do
    it "routes get '/users/password/new' to devise/passwords#new" do
      get('/users/password/new').should route_to "devise/passwords#new"
    end

    it "routes get '/users/password/edit' to devise/passwords#edit" do
      get('/users/password/edit').should route_to "devise/passwords#edit"
    end

    it "routes put '/users/password' to devise/passwords#update" do
      put('/users/password').should route_to "devise/passwords#update"
    end
  end
end
