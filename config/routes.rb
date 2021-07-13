Rails.application.routes.draw do
  root to: 'homepage#index'

  resources :books, only: [:index, :show]

  resources :categories do
    resources :books, :index
  end
end
