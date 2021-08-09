Rails.application.routes.draw do
  root to: 'homepage#index'

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  get '/users', to: redirect('users/sign_up')

  resources :catalog, controller: 'catalog', only: :index
  resources :books, only: :show
  resources :categories, controller: 'catalog' do
    member do
      get 'catalog', to: 'catalog#index'
    end
  end

  resources :accounts
  resources :change_emails
  resources :addresses
  resources :billing_addresses, controller: 'addresses'
  resources :shipping_addresses, controller: 'addresses'
end
