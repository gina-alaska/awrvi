Rails.application.routes.draw do
  resources :choices
  resources :categories
  resources :communities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root 'welcome#index'

  get '/welcome' => 'welcome#index'
end
