Rails.application.routes.draw do
  get 'change_locale/:locale', to: 'application#change_locale', as: :change_locale
  resources :profiles do 
    get 'approved', to: 'profiles#approved', as: :approved
    get 'rejected', to: 'profiles#rejected', as: :rejected
    get 'document', to: 'profiles#document', as: :document, on: :collection
    get 'bookings', to: 'profiles#bookings', as: :bookings, on: :collection
    
  end
  resources :admins
  resources :rules
  resources :properties
  resources :cars
  resources :models
  resources :brands
  resources :pages do
    get 'about', to: 'pages#about_us', as: :about_us, on: :collection
    get 'contact', to: 'pages#contact', as: :contact, on: :collection
    get 'privacy_policy', to: 'pages#privacy_policy', as: :privacy_policy, on: :collection
    get 'help_center', to: 'pages#help_center', as: :help_center, on: :collection
    get 'faqs', to: 'pages#faqs', as: :faqs, on: :collection
    get 'term', to: 'pages#term', as: :term, on: :collection
  end
  devise_for :users
  get 'admins/:id/permit', to: 'admins#permit', as: :admin_permit
  get 'admins/:id/nopermit', to: 'admins#nopermit', as: :admin_nopermit
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "dashboard#index"
end
