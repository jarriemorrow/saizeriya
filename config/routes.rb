Rails.application.routes.draw do
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" 
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  get "terms_of_service" => "tops#terms_of_service"
  get "polocy" => "tops#policy"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
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
