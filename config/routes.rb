Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/auth/login', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show] do
        resources :posts do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

  devise_for :users 

  devise_scope  :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end
end
