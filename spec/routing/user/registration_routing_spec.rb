describe Users::RegistrationsController do
  describe "routing" do
    it "routes get '/sign_up' to users/registration#new" do
      get('/sign_up').should route_to "users/registrations#new"
    end

    it "routes post '/sign_up' to users/registration#create" do
      post('/sign_up').should route_to "users/registrations#create"
    end

    it "routes put '/sign_up' to users/registrations#update" do
      put('/sign_up').should route_to "users/registrations#update"
    end

    it "routes get '/profile' to users/registration#edit" do
      get('/profile').should route_to "users/registrations#edit"
    end
  end
end
