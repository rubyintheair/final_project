Rails.application.routes.draw do

  
  
  get 'purposes/new'

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :purposes
  root "homes#index"
end
