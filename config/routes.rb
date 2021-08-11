Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'homepage#index'

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
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
