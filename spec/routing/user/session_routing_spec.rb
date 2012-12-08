describe "user session" do
  describe "routing" do
    it "routes get '/sign_in' to users/sessions#new" do
      get('/sign_in').should route_to "users/sessions#new"
    end

    it "routes post '/sign_in' to users/sessions#create" do
      post('/sign_in').should route_to "users/sessions#create"
    end

    it "routes get '/sign_out' to users/sessions#destroy" do
      get('/sign_out').should route_to "users/sessions#destroy"
    end
  end
end
