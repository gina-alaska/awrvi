Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :choices, except: :destroy
  resources :categories, except: :destroy
  resources :communities, shallow: true do
    resources :indices do
      resources :reviews, only: [:create, :destroy]

      patch :publish, on: :member
    end
  end

  namespace :manage do
    resources :users, except: [:new, :create] # These are handled by devise
    resources :indices, only: [:edit, :update]
  end

  resources :profile, only: [:show, :edit, :update], controller: 'manage/users'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  # root 'welcome#index'

  # get '/welcome' => 'welcome#index'
  get "*id" => 'pages#show', as: :page, format: false

  # if routing the root path, update for your controller
  root to: 'pages#show', id: 'home'
end
