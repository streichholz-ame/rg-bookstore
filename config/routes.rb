Rails.application.routes.draw do
  root to: 'homepage#index'

  resources :catalog, :controller => 'catalog', only: :index 

  resources :books, only: :show

  resources :categories, :controller => 'catalog' do #path: 'catalog/categories'
    member do
      get 'catalog', to: 'catalog#index'
    end
  end
end
