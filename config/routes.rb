Rails.application.routes.draw do
  resources :users
  post "follow/:id", to: "follows#create", as: "follow"
  delete "unfollow/:id", to: "follows#destroy", as: "unfollow"

  post "search", to: "users#search"

  root "microposts#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :microposts, only: %i(index create destroy) do
    resources :comments, only: :create
  end


end
