Rails.application.routes.draw do
  root to: "welcome#index"

  get 'auth/github', as: "github_login"
  get '/users/auth/paypal_oauth2/callback', to: "users#create"
end
