Rails.application.routes.draw do
  resources :rules
  resources :properties
  resources :cars
  resources :models
  resources :brands
  resources :pages
  get 'about', to: 'pages#about_us', as: "about_us"
  get 'contact', to: 'pages#contact', as: "contact"
  get 'privacy_policy', to: 'pages#privacy_policy', as: "privacy_policy"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "dashboard#index"
end
