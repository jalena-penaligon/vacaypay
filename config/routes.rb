Rails.application.routes.draw do
  root to: "welcome#index"
  get '/dashboard', to: 'users/vacations#index', as: :dashboard

  get '/oauth', to: 'users/users#create', as: :users_auth


  resources :vacations, only: [:show, :new, :create]
  resources :users, only: [:new, :create]
  resources :dwolla, only: [:new, :create]

  namespace :owner do
    resources :vacations, only: [:show]
  end
end
