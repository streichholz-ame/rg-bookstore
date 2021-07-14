Rails.application.routes.draw do
  root to: 'homepage#index'

  resources :catalog, :controller => 'catalog', only: :index

  resources :books, only: :show

  resources :categories do
    resources :books, :index
  end
end
