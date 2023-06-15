Rails.application.routes.draw do
  get 'sandbox/index'
  get 'sandbox/show'
  get 'sandbox/rent'

  post '/create-payment-intent', to: 'sandbox#create_payment_intent'
  get '/recent-accounts', to: 'sandbox#recent_accounts'
  get '/express-dashboard-link', to: 'sandbox#express_dashboard_link'
  get '/webhook', to: 'sandbox#webhook'

  
  resources :rules
  resources :properties
  resources :cars
  resources :models
  resources :brands
  devise_for :users
  
  resources :bank_accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "dashboard#index"
end
