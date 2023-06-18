Rails.application.routes.draw do
  resources :admins
  resources :rules
  resources :properties
  resources :cars
  resources :models
  resources :brands
  devise_for :users
  get 'admins/:id/permit', to: 'admins#permit', as: :admin_permit
  get 'admins/:id/nopermit', to: 'admins#nopermit', as: :admin_nopermit
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "dashboard#index"
end
