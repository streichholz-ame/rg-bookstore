Rails.application.routes.draw do
  root to: 'homepage#index'

  devise_for :users, controllers: { omniauth_callbacks: 'auth/callbacks', registrations: 'users/registrations' }
  get '/users' => redirect('users/sign_up')

  resources :catalog, controller: 'catalog', only: :index
  resources :books, only: :show
  resources :categories, controller: 'catalog' do
    member do
      get 'catalog', to: 'catalog#index'
    end
  end
end
