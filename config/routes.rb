Rails.application.routes.draw do
  root to: 'homepage#index'

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  get '/users' => redirect('users/sign_up')

  resources :catalog, controller: 'catalog', only: :index
  resources :books, only: :show
  resources :categories, controller: 'catalog' do
    member do
      get 'catalog', to: 'catalog#index'
    end
  end

  # resources :settings
  resources :accounts
  resources :change_emails
  resources :addresses
  resources :billing_addresses, controller: 'addresses'
  resources :shipping_addresses, controller: 'addresses'
end
