Lelylan::Application.routes.draw do

  namespace :oauth do
    get "authorize" => "oauth_authorize#show", defaults: { format: "html" }
    post "authorize/grant" => "oauth_authorize#create", defaults: { format: "html" }
    delete "authorize/deny" => "oauth_authorize#destroy", defaults: { format: "html" }
    post "token" => "oauth_token#create", defaults: { format: "json" }
  end

  get "log_out" => "sessions#destroy", as: "log_out"
  get "log_in"  => "sessions#new",     as: "log_in"
  get "sign_up" => "users#new",        as: "sign_up"
  root :to => "users#new"

  resources :users
  resources :sessions

end