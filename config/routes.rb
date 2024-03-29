Lhc::Application.routes.draw do
  resources :icebreaker_answers

  resources :notifications

  resources :user_documents

  resources :quiz_answers

  resources :quiz_categories

  resources :quizzes

  resources :queries

  resources :recipients

  resources :messages

  resources :answers

  resources :options

  resources :quests

  resources :ice_breakers

  #devise_for :users
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount RailsAdminImport::Engine => '/rails_admin_import', :as => 'rails_admin_import'

  get "home/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'home#index'

  devise_scope :user do
    post 'update', to: 'users/registrations#update', as: :update_profile

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
  get '/about_us_mobile'=>'home#about_us_mobile', as: :about_us_mobile

  get '/contact_us'=>'home#contact_us', as: :contact_us
  get '/contact_us_mobile'=>'home#contact_us_mobile', as: :contact_us_mobile

  get '/fill_matching_criteria', to: 'criterions#fill_matching_criteria', as: :fill_matching_criteria
  post '/create_matching_criteria', to: 'criterions#create_matching_criteria', as: :create_matching_criteria

  get '/fill_about_me', to: 'mandatory_details#fill_about_me', as: :fill_about_me
  get '/fill_about_me_mobile', to: 'mandatory_details#fill_about_me_mobile', as: :fill_about_me_mobile

  get '/fill_ilike', to: 'mandatory_details#fill_ilike', as: :fill_ilike
  get '/fill_ilike_mobile', to: 'mandatory_details#fill_ilike_mobile', as: :fill_ilike_mobile

  get '/fill_profilepic', to: 'mandatory_details#fill_profilepic', as: :fill_profilepic
  get '/fill_profilepic_mobile', to: 'mandatory_details#fill_profilepic_mobile', as: :fill_profilepic_mobile

  get '/fill_future_plan', to: 'mandatory_details#future_plan', as: :fill_future_plan
  get '/fill_future_plan_mobile', to: 'mandatory_details#future_plan_mobile', as: :fill_future_plan_mobile

  get '/fill_friend_speak', to: 'mandatory_details#friend_speak', as: :fill_friend_speak
  get '/fill_friend_speak_mobile', to: 'mandatory_details#friend_speak_mobile', as: :fill_friend_speak_mobile

  get '/fill_dates', to: 'mandatory_details#fill_dates', as: :fill_dates
  get '/fill_dates_mobile', to: 'mandatory_details#fill_dates_mobile', as: :fill_dates_mobile

  get '/fill_smoking', to: 'mandatory_details#fill_smoking', as: :fill_smoking
  get '/fill_smoking_mobile', to: 'mandatory_details#fill_smoking_mobile', as: :fill_smoking_mobile

  get '/fill_drinking', to: 'mandatory_details#fill_drinking', as: :fill_drinking
  get '/fill_drinking_mobile', to: 'mandatory_details#fill_drinking_mobile', as: :fill_drinking_mobile

  post '/create_message', to: 'dashboards#create_message', as: :create_message

  get '/welcome_dashboard', to: 'dashboards#welcome_dashboard', as: :welcome_dashboard
  get '/welcome_dashboard_mobile', to: 'dashboards#welcome_dashboard_mobile', as: :welcome_dashboard_mobile

  get '/my_dashboard', to: 'dashboards#my_dashboard', as: :my_dashboard
  get '/my_dashboard_mobile', to: 'dashboards#my_dashboard_mobile',as: :my_dashboard_mobile

  get '/conversations', to: 'dashboards#conversations', as: :conversations
  get '/conversations_mobile', to: 'dashboards#conversations_mobile', as: :conversations_mobile

  get '/conversations_with_users/:id', to: 'dashboards#conversations_with_users', as: :conversations_with_users
  get '/conversations_with_users_mobile/:id', to: 'dashboards#conversations_with_users_mobile', as: :conversations_with_users_mobile

  get '/quick_matches', to: 'dashboards#quick_matches', as: :quick_matches
  get '/quick_matches_mobile', to: 'dashboards#quick_matches_mobile', as: :quick_matches_mobile

  get '/mutual_likes', to: 'dashboards#mutual_likes', as: :mutual_likes
  get '/mutual_likes_mobile', to: 'dashboards#mutual_likes_mobile', as: :mutual_likes_mobile

  get '/snazzmeup', to: 'dashboards#snazzmeup', as: :snazzmeup
  get '/snazzmeup_mobile', to: 'dashboards#snazzmeup_mobile', as: :snazzmeup_mobile

  get '/younme/:id', to: 'dashboards#younme', as: :younme
  get '/younme_mobile/:id', to: 'dashboards#younme_mobile', as: :younme_mobile

  get '/under_construction', to: 'dashboards#under_construction', as: :under_construction


  get '/user_verification', to: 'dashboards#user_verification', as: :user_verification
  get '/user_verification_mobile', to: 'dashboards#user_verification_mobile', as: :user_verification_mobile

  match '/verify_user_institute_email', to: 'dashboards#verify_user_institute_email', via: [:post]
  get '/start_verify_user_institute_email/:user_id/:token', to: 'dashboards#start_verify_user_institute_email', as: :start_verifying_user
  match '/verify_user_linkedin_url', to: 'dashboards#verify_user_linkedin_url', via: [:post]
  match '/upload_user_doc', to: 'dashboards#upload_user_doc', via: [:post]

  get '/start_ice_breaker/:id/(:prev_msg)', to: 'dashboards#start_ice_breaker', as: :start_ice_breaker
  get '/start_ice_breaker_mobile/:id/(:prev_msg)', to: 'dashboards#start_ice_breaker_mobile', as: :start_ice_breaker_mobile

  get '/take_test/:id/:question_id', to: 'quiz_categories#take_test',as: :take_test
  get '/take_test_mobile/:id/:question_id', to: 'quiz_categories#take_test_mobile',as: :take_test_mobile

  get '/quiz_review/:quiz_id', to: 'dashboards#quiz_review',as: :quiz_review
  get '/quiz_review_mobile/:quiz_id', to: 'dashboards#quiz_review_mobile',as: :quiz_review_mobile

  get '/retest/:quiz_id', to: 'quiz_answers#retest',as: :retest
  get '/retest_mobile/:quiz_id', to: 'quiz_answers#retest_mobile',as: :retest_mobile


  get '/answer_icebreaker/:id/:question_id', to: 'dashboards#answer_icebreaker',as: :answer_icebreaker
  get '/answer_icebreaker_mobile/:id/:question_id', to: 'dashboards#answer_icebreaker_mobile',as: :answer_icebreaker_mobile

  get '/start_test/:id', to: 'quiz_categories#start_test',as: :start_test
  get '/start_test_mobile/:id', to: 'quiz_categories#start_test_mobile',as: :start_test_mobile

  get '/user_answer/:id', to: 'quiz_categories#user_answer',as: :user_answer

  get '/profile/:id', to: 'demographics#profile',as: :user_profile
  get '/profile_mobile/:id', to: 'demographics#profile_mobile',as: :profile_mobile

  get '/edit_profile/:id', to: 'demographics#edit_profile', as: :edit_profile
  get '/edit_profile_mobile/:id', to: 'demographics#edit_profile_mobile', as: :edit_profile_mobile
  #post '/update_profile', to: 'demographics#update_profile'

  get '/search_movies_ruby', to: 'demographics#search_movies_ruby'
  #post '/search_movies_themoviedb', to: 'demographics#search_movies_themoviedb'
  match '/search_movies_themoviedb', to: 'demographics#search_movies_themoviedb', via: [:get, :post]
  match '/search_movies_by_rovicorp', to: 'demographics#search_movies_by_rovicorp', via: [:get, :post]
  match '/search_movies_by_rotten_tomatoes', to: 'demographics#search_movies_by_rotten_tomatoes', via: [:get, :post]

  match '/add_user_movie', to: 'demographics#add_user_movie', via: [:get, :post]
  match '/add_user_book', to: 'demographics#add_user_book', via: [:get, :post]
  match '/add_user_music', to: 'demographics#add_user_music', via: [:get, :post]

  match '/delete_user_movie', to: 'demographics#delete_user_movie', via: [:get, :post]
  match '/delete_user_book', to: 'demographics#delete_user_book', via: [:get, :post]
  match '/delete_user_song', to: 'demographics#delete_user_song', via: [:get, :post]
  match '/delete_user_quiz', to: 'demographics#delete_user_quiz', via: [:get, :post]
  match '/add_user_quiz', to: 'demographics#add_user_quiz', via: [:get, :post]

  match '/search_music_gmusic', to: 'demographics#search_music_gmusic', via: [:get, :post]
  match '/search_music_by_lastfm', to: 'demographics#search_music_by_lastfm', via: [:get, :post]

  match '/search_book_db', to: 'demographics#search_book_db', via: [:get, :post]
  match '/invitee_friends', to: 'dashboards#invitee_friends', via: :post

  get '/user_like/:id', to: 'dashboards#user_like', as: :user_like
  get '/accept_request/:id', to: 'dashboards#accept_request', as: :accept_request
  get '/reject_request/:id', to: 'dashboards#reject_request', as: :reject_request
  match '/reject_match/:id', to: 'dashboards#reject_match', as: :reject_match, via: [:get, :post]
  match '/block_user/:id', to: 'dashboards#block_user', as: :block_user, via: [:get, :post]

  get '/users/auth/:provider/callback' => 'authentications#create'

  #get '/import_domain', to: 'dashboards#import_domain_name' ,as: :domain_name
  #match '/import_domain_name', to: 'dashboards#importing_institute' ,as: :importing, via: [:get, :post]



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
