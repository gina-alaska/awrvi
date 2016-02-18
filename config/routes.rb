Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :indices
  resources :choices, except: :destroy
  resources :categories, except: :destroy
  resources :communities

  namespace :manage do
    resources :users, except: [:new, :create] # These are handled by devise
  end

  resource :profile, only: [:show, :edit, :update], controller: 'manage/users'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root 'welcome#index'

  get '/welcome' => 'welcome#index'
end
