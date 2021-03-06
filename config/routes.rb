WorkApp::Application.routes.draw do
  resources :votes, :only => [:new, :create, :destroy]
  resources :subscriptions, :only => [:new, :create, :destroy]
  resources :replies, :only => [:new, :create, :destroy, :show]
  resources :posts, :only => [:new, :create]
  resources :comments, :only => [:show, :new, :create]


  resources :users
  resources :subreddits do
    resources :posts, :except => [:new, :create, :destroy] do
      resources :comments, :except => [:create, :show, :new, :destroy]
    end
  end
  match '/reply', :to => 'comments#reply', :as => 'reply_to_comment', :via => :get
  match '/vote', :to => 'posts#vote', :as => 'vote_subreddit_post', :via => :get
  match '/vote_comment', :to => 'comments#vote', :as => 'vote_post_comment', :via => :get
  match '/vote_reply', :to => 'replies#vote', :as => 'vote_comment_reply', :via => :get
  match '/posts/new_link', :to => 'posts#new', :as => 'new_link_post', :via => :get
  match '/posts/new_text', :to => 'posts#new', :as => 'new_text_post', :via => :get
  match '/subscribe', :to => 'subreddits#subscribe', :as => 'subscribe_subreddit', :via => :get
  match '/posts/:post_id/', :to => 'comments#new', :as => 'new_comment', :via => :get
  match '/subreddits/:subname/posts/:post_id/comments/:id', :to => 'comments#show', :as => 'show_user_comment'
  match '/subreddits/:subname/posts/:post_id/replies/:id', :to => 'replies#show', :as => 'show_user_reply'
  resources :sessions, :only => [:new, :create, :destroy]
  resources :messages, :only => [:new, :show, :index]
  match '/', :to => 'static_pages#home'
  #match '/subreddits/:subreddit_id/posts/:id/vote/:direction', :to => 'posts#vote', :as => 'vote_subreddit_post'
  match '/help', :to => 'static_pages#help'
  match '/signin', :to => 'sessions#new'
  match '/signup', :to => 'users#new'
  match '/signout', :to => 'sessions#destroy', :via => :delete
  match '/messages', :to => 'messages#new'
  root :to => 'static_pages#home'



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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
