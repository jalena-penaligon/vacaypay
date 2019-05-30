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
    resources :funding_sources, only: [:new]
    resources :vacations, only: [:create, :new, :show, :index] do
      resources :activities, only: [:show, :new, :create]
    end
    resources :activities, only: [] do
      resources :user_activities, only: [:create, :destroy]
    end
  end

  get '/update_funding_source', to: 'users#update'

  resources :vacations, only: [:show, :new, :create] do
    namespace :owner do
      resources :activities
    end

  post '/transfer', to: 'users/dwollas#transfer', as: :dwollas_transfer
  end

  resources :users, only: [:new, :create, :update]

  namespace :owner do
    resources :vacations, only: [:show] do
      get '/invite', to: 'invitations#new'
      post '/invite', to: 'invitations#create'
    end
    resources :activities, only: [] do
      member {patch :mass_invite}
      resources :user_activities, only: [:create, :new]
    end
  end

  get '/vacation/:id/messages', to: 'messages#index', as: :vacation_messages
  post '/vacation/:id/messages', to: 'messages#create'
  # resources :messages, only: [:index, :create]

  mount ActionCable.server, at: '/cable'
end
