Rails.application.routes.draw do

  root 'application#home'

  get '/home', to: 'application#home'

  #get '/bar/:id', to: 'application#bar', id: 3

  #get '/bar/:tag', to: 'application#bar', as: :tagged_products

  #match 'bar/:name', :to => 'application#bar'

  get '/bar/:width/:height', to: 'application#bar'

  #root 'nice#index'
  #match via: [:get, :post] "/" => 'nice#index'
  # match '/5.0/:width/:height' => 'nice#fivepointoh', :constraints => { :width => /[0-9]+/, :height => /[0-9]+/ }
  # match '/5.0/:square' => 'nice#fivepointohsquare', :constraints => { :square => /[0-9]+/ }
  # match '/:width/:height' => 'nice#vanilla', :constraints => { :width => /[0-9]+/, :height => /[0-9]+/ }
  # match '/:square' => 'nice#vanillasquare', :constraints => { :square => /[0-9]+/ }
  # match '/*anythingelse' => 'nice#index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
