Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  scope "(:locale)", locale: /en|pl|zh/ do
    resources :posts
  end
  resources :users
  get '/blog' => 'posts#index', locale: /en|pl|zh/, show_all: false
  get '/:locale/blog' => 'posts#index', locale: /en|pl|zh/, show_all: false
  get '/:locale' => 'pages#home', locale: /en|pl|zh/
  get "/:locale/about" => 'pages#about', locale: /en|pl|zh/
  get "/:locale/links" => 'pages#links', locale: /en|pl|zh/
  get "/faq" => 'pages#faq'
  get "/about" => 'pages#about'
  resources :blog, :controller => 'posts', :only => [:show]
  match '/latest' => 'posts#show', :id => Post.blog.first.id, :via => [:get]

  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :log_out

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
