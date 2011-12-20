
#== Route Map
# Generated on 05 Dec 2011 10:33
#
#                   POST   /users(.:format)                  {:action=>"create", :controller=>"users"}
#          new_user GET    /users/new(.:format)              {:action=>"new", :controller=>"users"}
#         edit_user GET    /users/:id/edit(.:format)         {:action=>"edit", :controller=>"users"}
#              user GET    /users/:id(.:format)              {:action=>"show", :controller=>"users"}
#                   PUT    /users/:id(.:format)              {:action=>"update", :controller=>"users"}
#                   DELETE /users/:id(.:format)              {:action=>"destroy", :controller=>"users"}
#     user_sessions GET    /user_sessions(.:format)          {:action=>"index", :controller=>"user_sessions"}
#                   POST   /user_sessions(.:format)          {:action=>"create", :controller=>"user_sessions"}
#  new_user_session GET    /user_sessions/new(.:format)      {:action=>"new", :controller=>"user_sessions"}
# edit_user_session GET    /user_sessions/:id/edit(.:format) {:action=>"edit", :controller=>"user_sessions"}
#      user_session GET    /user_sessions/:id(.:format)      {:action=>"show", :controller=>"user_sessions"}
#                   PUT    /user_sessions/:id(.:format)      {:action=>"update", :controller=>"user_sessions"}
#                   DELETE /user_sessions/:id(.:format)      {:action=>"destroy", :controller=>"user_sessions"}
#         questions GET    /questions(.:format)              {:action=>"index", :controller=>"questions"}
#                   POST   /questions(.:format)              {:action=>"create", :controller=>"questions"}
#      new_question GET    /questions/new(.:format)          {:action=>"new", :controller=>"questions"}
#     edit_question GET    /questions/:id/edit(.:format)     {:action=>"edit", :controller=>"questions"}
#          question GET    /questions/:id(.:format)          {:action=>"show", :controller=>"questions"}
#                   PUT    /questions/:id(.:format)          {:action=>"update", :controller=>"questions"}
#                   DELETE /questions/:id(.:format)          {:action=>"destroy", :controller=>"questions"}
#              root        /(.:format)                       {:controller=>"pages", :action=>"home"}
#             about        /about(.:format)                  {:controller=>"pages", :action=>"about"}
#              help        /help(.:format)                   {:controller=>"pages", :action=>"help"}
#        candidates        /candidates(.:format)             {:controller=>"users", :action=>"index"}
#          register        /register(.:format)               {:controller=>"users", :action=>"new"}
#            signin        /signin(.:format)                 {:controller=>"user_sessions", :action=>"new"}
#           signout        /signout(.:format)                {:controller=>"user_sessions", :action=>"destroy"}

McpForum::Application.routes.draw do

  resources :users
  resources :user_sessions
  resources :questions
  
  root            :to => 'pages#home'
  
  match '/about', :to => 'pages#about'
  match '/help',  :to => 'pages#help'
  
  match '/candidates', :to => 'users#index'
  match '/register',   :to => 'users#new'
  match '/signin',     :controller => "user_sessions", :action => "new"
  match '/signout',    :controller => "user_sessions", :action => "destroy"
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
