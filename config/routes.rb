Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'homepage#index'

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  post 'users/auth/:provider/callback', to: 'sessions#create'
  match 'users/auth/failure', to: redirect('/'), via: %i[get post]
  post 'signout', to: 'sessions#destroy', as: 'signout'
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
  resources :reviews
end
