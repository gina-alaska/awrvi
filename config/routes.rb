Rails.application.routes.draw do
  resources :choices
  resources :categories
  resources :communities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  # TODO: Set this to something real.  Devise requires it to be set, so I'm using
  # communities#index until the welcome page PR is merged.
  root to: 'communities#index'
end
