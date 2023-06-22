Rails.application.routes.draw do
  get 'sandbox/index'
  get 'sandbox/show'
  get 'sandbox/rent'

  post '/create-payment-intent', to: 'sandbox#create_payment_intent'
  get '/recent-accounts', to: 'sandbox#recent_accounts'
  get '/express-dashboard-link', to: 'sandbox#express_dashboard_link'
  get '/webhook', to: 'sandbox#webhook'

  get 'change_locale/:locale', to: 'application#change_locale', as: :change_locale
  patch '/profiles', to: 'profiles#update', as: 'update_profile' # TODO: We can delete it. because resources already creating it.
  get 'bookings', to: 'profiles#bookings', as: "bookings" # TODO: Move to profiles block

  resources :profiles
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
