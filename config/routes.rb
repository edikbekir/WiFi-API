Rails.application.routes.draw do
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'verify'  => 'sessions#verify_access_token'
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :macs
      post 'get_events', to: 'events#get_events'
      post 'update_event', to: 'events#update_event'
      get 'index', to: 'events#index'
      post 'create', to: 'bssid#create'
      post   'login'   => 'sessions#create'
      delete 'logout'  => 'sessions#destroy'
      get    'verify'  => 'sessions#verify_access_token'
      resources :visitors, param: :access_token
      resources :password_resets, only: [:new, :create, :edit, :update]
    end
  end
end
