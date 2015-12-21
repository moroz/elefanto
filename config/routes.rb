Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  scope "(:locale)", locale: /en|pl|zh|eo/ do
    resources :posts do
      resources :comments, shallow: true
    end
    get '/blog' => 'posts#index', show_all: false, :as => :blog
    get "/about" => 'pages#about', as: :about
    get '/' => 'pages#home', as: :home
    get ':id(/:slug)' => 'posts#show', as: 'post_slug'
    resources :visits, :only => [:index]
    get "/visits/:post_id" => 'visits#show', :as => 'show_visits'
    resources :categories do
      member do
        get 'manage'
        post 'remove' => 'categories#remove_post'
        post 'add' => 'categories#add_post'
      end
    end
  end
  resources :users
  resources :blog, :controller => 'posts', :only => [:show]

  get "/log-in" => "sessions#new", as: :login
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :logout
  get "/schedule" => "pages#schedule"

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
