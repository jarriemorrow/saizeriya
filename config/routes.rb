Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/new'
  get 'posts/show'
  root 'tops#index'
  resources :users, only: %i[new create show]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :posts do
    collection do
      get :likes
    end
  end
  resources :likes, only: %i[create destroy]
end
