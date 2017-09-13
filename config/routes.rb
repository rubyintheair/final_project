Rails.application.routes.draw do

  get 'currencies/new'

  get 'currencies/index'

  get 'banks/display'

  get 'terms/new'

  get 'terms/index'

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"
  get "bank" => "banks#display"
  get "index_1" => "daily_cashflows#index_1"
  get "index_2" => "daily_cashflows#index_2"
  get "daily_report" => "daily_cashflows#daily_report"
  get "monthly_report" => "daily_cashflows#monthly_report"
  get "yearly_report" => "daily_cashflows#yearly_report"
  get "all" => "daily_cashflows#all_report"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :purposes
  resources :friends
  resources :daily_cashflows do 
    collection do 
      get :search
    end 
  end 
  resources :terms
  resources :currencies 
  root "daily_cashflows#daily_report"
end
