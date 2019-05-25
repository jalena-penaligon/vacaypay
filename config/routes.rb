Rails.application.routes.draw do
  root to: "welcome#index"

  get '/dashboard', to: 'users/vacations#index', as: :dashboard
end
