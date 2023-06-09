Rails.application.routes.draw do
  get 'profiles/index'
  patch '/profiles', to: 'profiles#update', as: 'update_profile'
  patch '/profiles', to: 'profiles#update_password', as: 'update_profile_password'


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
