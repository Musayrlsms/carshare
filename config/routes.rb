Rails.application.routes.draw do
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "dashboard#index"
end
