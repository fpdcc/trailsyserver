Trailsyserver::Application.routes.draw do
  resources :trail_subtrails
  resources :trail_systems
  get 'dashboard/index'

  resources :picnicgroves
  resources :pointsofinterests do 
    resources :alertings
  end
  resources :parking_entrances
  resources :poi_descs
  resources :names
  resources :new_trails
  resources :trails_descs
  resources :trails_infos
  resources :alertings
  resources :alerts do
    resources :alertings
    collection do
      get 'poi'
      get 'trail'
    end
  end
 
  resources :activities do
    collection do
      post 'upload'
    end
  end

  resources :organizations

  devise_for :users, :controllers => { :registrations => "registrations" }
  
  scope "/admin" do
    resources :users do
      member do
        get :approve
      end
    end
  end
  
  resources :trailsegments do
    collection do
      post 'upload'
    end
  end

  resources :trailheads do
    collection do
      post 'upload'
    end
  end

  resources :trails do
    collection do
      post 'upload'
    end
  end

  get '.well-known/status' => 'status#check'

  get '/admin' => 'alerts#poi'
  
  root to: 'alerts#poi'

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
