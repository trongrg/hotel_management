HotelManagement::Application.routes.draw do
  post 'geocoder/get_location', :as => :get_location
  post 'geocoder/get_address', :as => :get_address

  root :to => 'home#index'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match '/resque/trongtran', :to => Resque::Server, :anchor => false

  devise_for :users,
    :skip => [:sessions, :registrations],
    :controllers => {
      :sessions => 'users/sessions',
      :registrations => 'users/registrations'
    }

  devise_scope :user do
    get '/sign_in' => 'users/sessions#new', :as => :new_user_session
    post '/sign_in' => 'users/sessions#create', :as => :user_session
    get '/sign_out' => 'users/sessions#destroy', :as => :destroy_user_session
    get '/profile' => 'users/registrations#edit', :as => :edit_user_registration
    put '/sign_up' => 'users/registrations#update', :as => :user_registration
    get '/sign_up' => 'users/registrations#new', :as => :new_user_registration
    post '/sign_up' => 'users/registrations#create', :as => :user_registration
    get '/profile/password' => 'users/password#edit', :as => :edit_profile_password
    put '/profile/password' => 'users/password#update', :as => :profile_password
  end

  resources :hotels do
    resources :room_types
    resources :rooms
    resources :reservations
    resources :check_ins
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with 'root'
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with 'rake routes'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
