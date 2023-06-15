Rails.application.routes.draw do
  patch '/profiles', to: 'profiles#update', as: 'update_profile'
  get 'bookings', to: 'profiles#bookings', as: "bookings"
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
