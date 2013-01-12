require 'spec_helper'

describe RoomsController do
  describe 'routing' do

    it 'routes to #index' do
      get('/hotels/1/rooms').should route_to('rooms#index', :hotel_id => '1')
    end

    it 'routes to #new' do
      get('/hotels/1/rooms/new').should route_to('rooms#new', :hotel_id => '1')
    end

    it 'routes to #show' do
      get('/hotels/1/rooms/1').should route_to('rooms#show', :id => '1', :hotel_id => '1')
    end

    it 'routes to #edit' do
      get('/hotels/1/rooms/1/edit').should route_to('rooms#edit', :id => '1', :hotel_id => '1')
    end

    it 'routes to #create' do
      post('/hotels/1/rooms').should route_to('rooms#create', :hotel_id => '1')
    end

    it 'routes to #update' do
      put('/hotels/1/rooms/1').should route_to('rooms#update', :id => '1', :hotel_id => '1')
    end

    it 'routes to #destroy' do
      delete('/hotels/1/rooms/1').should route_to('rooms#destroy', :id => '1', :hotel_id => '1')
    end

  end
end

