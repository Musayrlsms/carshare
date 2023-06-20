Rails.application.routes.draw do
  get 'change_locale/:locale', to: 'application#change_locale', as: :change_locale
  get 'bookings', to: 'profiles#bookings', as: "bookings" # TODO: Move to profiles block
  get 'profiles/document', to: 'profiles#document', as: 'document'
  resources :profiles do 
    get 'approved', to: 'profiles#approved', as: :approved
    get 'rejected', to: 'profiles#rejected', as: :rejected
    

  end
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
