HotelManagement::Application.routes.draw do
  resources :hotels do
    resources :rooms
    resources :room_types
  end

  resources :room_types, :only => [] do
    resources :furnishings
  end

  devise_for :users, :skip => [:sessions, :registrations],
    :controller => {:sessions => "sessions", :registrations => "registrations"}
  devise_scope :user do
    get '/sign_in' => "sessions#new", :as => :new_user_session
    post '/sign_in' => "sessions#create", :as => :user_session
    get '/sign_out' => "sessions#destroy", :as => :destroy_user_session
    get '/sign_up' => "registrations#new", :as => :new_user_registration
    post '/sign_up' => "registrations#create", :as => :user_registration
    get '/profile' => "registrations#edit", :as => :edit_user_registration
    put '/sign_up' => "registrations#update"
  end

  resources :users

  resource :dashboard, :only => :show, :controller => "dashboard"

  namespace :profile do
    resource :password, :only => [:edit, :update], :controller => "password"
  end

  constraints(RolesConstraint.new(:user, :admin, :hotel_owner, :staff)) do
    root :to => 'dashboard#show'
  end
  root :to => 'welcome#show'
end
