Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get 'posts/index'
  get 'posts/new'
  get 'posts/show'
  root 'tops#index'
  resources :users
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :posts do
    collection do
      get :likes
    end
  end
  resources :likes, only: %i[create destroy]
  get 'search_menus', to: 'menus#search'
  resources :password_resets, only: [:create, :edit, :update, :new]
end
