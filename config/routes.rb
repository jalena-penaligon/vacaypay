Rails.application.routes.draw do
  root to: "welcome#index"
  get '/dashboard', to: 'users/vacations#index', as: :dashboard

  get '/oauth', to: 'users/users#create', as: :users_auth


  resources :vacations, only: [:show]
  resources :users, only: [:new, :create]
  resources :dwolla, only: [:new, :create]

end
