Rails.application.routes.draw do
  root to: "welcome#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/vacations', to: 'users/vacations#index', as: :vacations
  get '/dashboard', to: 'users#show', as: :dashboard

  get '/oauth', to: 'users/dwollas#create', as: :users_auth

  namespace :users do
    resources :dwollas, only: [:create, :new]
    resources :vacations, only: [:create, :new, :show, :index, :destroy, :update] do
      resources :activities, only: [:show]
    end
    resources :activities, only: [] do
      resources :user_activities, only: [:create, :destroy]
    end
  end

  resources :vacations, only: [:show, :new, :create] do
    namespace :owner do
      resources :activities
    end

  post '/transfer', to: 'dwollas#transfer', as: :dwollas_transfer
  resources :funding_sources, only: [:update]
  end

  resources :users, only: [:new, :create, :update]
  resources :dwolla, only: [:new, :create]
  resources :funding_sources, only: [:new]

  namespace :owner do
    resources :vacations, only: [:show]
    resources :activities, only: [] do
      resources :user_activities, only: [:create, :new]
    end
  end

end
