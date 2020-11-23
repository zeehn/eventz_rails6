Rails.application.routes.draw do
  root 'events#index'

  resources :events do 
    resources :registrations
  end

  resources :users
  get 'signup', to: 'users#new'

  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
end
