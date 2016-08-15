Rails.application.routes.draw do
  root 'pages#home'

  get "/log-in" => "sessions#new", as: :login
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :logout

  get '/subscribe' => "subscriptions#new", as: :new_subscription
  resources :subscriptions, only: [:create]
  resources :posts do
    post :publish, on: :member
    post :unpublish, on: :member
    resources :comments, shallow: true
  end
  get '/blog' => 'posts#index', show_all: false, :as => :blog
  get "/about" => 'pages#about', as: :about
  resources :visits, :only => [:index]
  get "/visits/:post_id" => 'visits#show', :as => 'show_visits'
  resources :categories do
    member do
      get 'manage'
      post 'remove' => 'categories#remove_post'
      post 'add' => 'categories#add_post'
    end
  end
  resources :users
  resources :blog, :controller => 'posts', :only => [:show]
  resources :images
end
