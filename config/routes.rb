Lhc::Application.routes.draw do
  resources :recipients

  resources :messages

  resources :answers

  resources :options

  resources :quests

  resources :ice_breakers

  #devise_for :users
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "home/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'home#index'

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root "devise/registrations#new", as: :unauthenticated_root
    end
  end

  resources :authentications

  resources :criterions
  resources :demographics
  resources :dashboards
  resources :tests

  get '/new_user_details/post_registration'=>'new_user_details#post_registration_details'

  get '/about_us'=>'home#about_us', as: :about_us
  get '/contact_us'=>'home#contact_us', as: :contact_us

  get '/fill_matching_criteria', to: 'criterions#fill_matching_criteria', as: :fill_matching_criteria
  post '/create_matching_criteria', to: 'criterions#create_matching_criteria', as: :create_matching_criteria

  get '/welcome_dashboard', to: 'dashboards#welcome_dashboard', as: :welcome_dashboard
  get '/my_dashboard', to: 'dashboards#my_dashboard', as: :my_dashboard
  get '/conversations', to: 'dashboards#conversations', as: :conversations
  get '/conversations_with_users', to: 'dashboards#conversations_with_users', as: :conversations_with_users
  get '/quick_matches', to: 'dashboards#quick_matches', as: :quick_matches
  get '/mutual_likes', to: 'dashboards#mutual_likes', as: :mutual_likes
  get '/snazzmeup', to: 'dashboards#snazzmeup', as: :snazzmeup
  get '/user_verification', to: 'dashboards#user_verification', as: :user_verification
  get '/start_ice_breaker/:id/(:prev_msg)', to: 'dashboards#start_ice_breaker', as: :start_ice_breaker

  get '/take_test/(:test_id)', to: 'tests#take_test'
  get '/start_test/(:test_id)', to: 'tests#start_test'

  get '/profile/:id', to: 'demographics#profile'
  get '/edit_profile/:id', to: 'demographics#edit_profile', as: :edit_profile
  post '/update_profile', to: 'demographics#update_profile'

  get '/search_movies_ruby', to: 'demographics#search_movies_ruby'
  #post '/search_movies_themoviedb', to: 'demographics#search_movies_themoviedb'
  match '/search_movies_themoviedb', to: 'demographics#search_movies_themoviedb', via: [:get, :post]

  match '/search_music_gmusic', to: 'demographics#search_music_gmusic', via: [:get, :post]


  match '/search_music_db', to: 'demographics#search_music_db', via: :post
  match '/search_book_db', to: 'demographics#search_book_db', via: [:get]

  get '/users/auth/:provider/callback' => 'authentications#create'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
