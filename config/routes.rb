Rails.application.routes.draw do






  get 'image/new/:draw_id' => 'image#new'
  post 'image/upload'


  resources :commentaries
  get 'commentaries/new/:article_id' => 'commentaries#new'

  resources :draws
  get 'draws/new/:article_id' => 'draws#new'



  resources :tips
	get 'tips/new/:article_id' => 'tips#new'

  resources :articles


  get '/welcome' => 'welcome#welcome'



  get '/connection' => 'connection#connection'
  post 'connection' => 'connection#verif'
	get '/deconnection' => 'connection#deconnection'

  resources :messages
  get '/message/new/:user_id' => 'messages#new'

  resources :followings
  get '/users/:follow/suivre' => 'followings#new'

  resources :users


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'connection#accueil'

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
