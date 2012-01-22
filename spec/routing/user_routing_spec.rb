describe UsersController do
  describe "routing" do
    it "routes GET '/users' to 'users#index'" do
      get('/users').should route_to('users#index')
    end

    it "routes POST '/users' to 'users#create'" do
      post('/users').should route_to('users#create')
    end

    it "routes GET '/users/:id' to 'users#show'" do
      get('/users/1').should route_to('users#show', :id => '1')
    end

    it "routes GET '/users/:id/edit' to 'users#edit'" do
      get('/users/1/edit').should route_to('users#edit', :id => '1')
    end

    it "routes PUT '/users/:id' to 'users#update'" do
      put('/users/1').should route_to('users#update', :id => '1')
    end

    it "routes GET '/users/new' to 'users#new'" do
      get('/users/new').should route_to('users#new')
    end

    it "routes DELETE '/users/:id' to 'users#destroy'" do
      delete('/users/1').should route_to('users#destroy', :id => '1')
    end
  end
end
