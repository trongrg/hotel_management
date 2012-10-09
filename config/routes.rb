HotelManagement::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :rooms, :only => [] do
    resources :check_ins
    resources :reservations
    resources :check_outs
  end

  resources :hotels do
    resources :rooms
    resources :room_types
    resources :staff, :controller => "staff", :only => [:index, :show, :destroy]
  end

  resources :room_types, :only => [] do
    resources :furnishings
  end

  devise_for :users,
    :skip => [:sessions, :registrations],
    :controllers => {:sessions => "sessions", :registrations => "registrations", :invitations => "invitations"}

  devise_scope :user do
    get '/sign_in' => "sessions#new", :as => :new_user_session
    post '/sign_in' => "sessions#create", :as => :user_session
    get '/sign_out' => "sessions#destroy", :as => :destroy_user_session
    get '/sign_up' => "registrations#new", :as => :new_user_registration
    post '/sign_up' => "registrations#create", :as => :user_registration
    get '/profile' => "registrations#edit", :as => :edit_user_registration
    put '/sign_up' => "registrations#update", :as => :user_registration
  end

  resources :users

  resource :dashboard, :only => :show, :controller => "dashboard"

  namespace :profile do
    resource :password, :only => [:edit, :update], :controller => "password"
  end

  constraints(RolesConstraint.new(:user, :hotel_owner, :staff)) do
    root :to => 'dashboard#show'
  end
  root :to => 'welcome#show'
end
