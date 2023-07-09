Rails.application.routes.draw do
  root "dashboard#index"
  devise_for :users

  resources :admins
  resources :rules
  resources :properties
  resources :models
  resources :brands
  resources :bank_accounts
  resources :payouts
  
  resources :cars do
    resources :rents do
      post 'create-payment-intent', to: 'rents#create_payment_intent', on: :collection
      get 'recent-accounts', to: 'rents#recent_accounts', on: :collection
      delete 'cancel', to: 'rents#cancel'
    end
  end
  
  resources :profiles do 
    get 'approved', to: 'profiles#approved', as: :approved, on: :member
    get 'rejected', to: 'profiles#rejected', as: :rejected, on: :member
    get 'document', to: 'profiles#document', as: :document, on: :collection
    get 'bookings', to: 'profiles#bookings', as: :bookings, on: :collection
    get 'bank_accounts', to: 'profiles#bank_accounts', as: :bank_accounts, on: :collection
    get 'balance', to: 'profiles#balance', as: :balance, on: :collection
  end
  
  resources :pages do
    get 'about', to: 'pages#about_us', as: :about_us, on: :collection
    get 'contact', to: 'pages#contact', as: :contact, on: :collection
    get 'privacy_policy', to: 'pages#privacy_policy', as: :privacy_policy, on: :collection
    get 'help_center', to: 'pages#help_center', as: :help_center, on: :collection
    get 'faqs', to: 'pages#faqs', as: :faqs, on: :collection
    get 'term', to: 'pages#term', as: :term, on: :collection
  end
  
  get 'admins/:id/permit', to: 'admins#permit', as: :admin_permit
  get 'admins/:id/nopermit', to: 'admins#nopermit', as: :admin_nopermit
  
  get 'payment-return', to: 'rents#payment_return'
  
  get 'change_locale/:locale', to: 'application#change_locale', as: :change_locale
end
