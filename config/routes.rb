Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :indices
  resources :choices, except: :destroy
  resources :categories, except: :destroy
  resources :communities
  resources :users, except: [:new, :create]  # These are handled by devise
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root 'welcome#index'

  get '/welcome' => 'welcome#index'
end
