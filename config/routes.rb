Rails.application.routes.draw do

  get 'banks/display'

  get 'terms/new'

  get 'terms/index'

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"
  get "bank" => "banks#display"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :purposes
  resources :cashflow_types
  resources :friends
  resources :daily_cashflows
  resources :terms
  root "homes#index"
end
