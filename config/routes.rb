Rails.application.routes.draw do
  get 'change_locale/:locale', to: 'application#change_locale', as: :change_locale
  patch '/profiles', to: 'profiles#update', as: 'update_profile' # TODO: We can delete it. because resources already creating it.
  get 'bookings', to: 'profiles#bookings', as: "bookings" # TODO: Move to profiles block

  resources :profiles
  resources :rules
  resources :properties
  resources :cars do
    resources :rents do
      post 'create-payment-intent', to: 'rents#create_payment_intent', on: :collection
      get 'recent-accounts', to: 'rents#recent_accounts', on: :collection
    end
  end
  resources :models
  resources :brands
  devise_for :users
  
  resources :bank_accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "dashboard#index"
  get 'payment-return', to: 'rents#payment_return'
end
