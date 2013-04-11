Zilup::Application.routes.draw do    
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  #get "log_out" => "sessions#destroy", :as => "log_out"
  #get "log_in" => "sessions#new", :as => "log_in"
  root :to => "sessions#new", :via => :get, :as => :new_session
  root :to => "sessions#create", :via => :post, :as => :create_session
  match "users/players" => "users#players_info", :as => :players
  match "users/games" => "users#games_info", :as => :games
  match "users/my_page" => "users#my_page", :as => :my_page
  
  match "sign_up" => "sessions#sign_up", :as => :sign_up
  match "log_in" => "sessions#log_in", :as => :log_in
  match "get_user_info" => "users#get_user_info", :as => :get_user_info
  match "get_game_info" => "users#get_game_info", :as => :get_game_info
  match "recommended_games" => "games#get_recommended_games", :as => :get_recommended_games
  match "send_new_score" => "games#send_new_score", :as => :send_new_score
  match "initialize_game_info" => "games#initialize_game_info", :as => :initialize_game_info
  
#  match "/sessions/create" => "sessions#create", :via => :post
  #resources :users
  #resources :sessions
  

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
