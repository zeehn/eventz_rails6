Rails.application.routes.draw do
  root 'events#index'

  get 'events/filter/:filter', to: 'events#index', as: 'filtered_events'
  resources :events do 
    resources :registrations
    resources :likes
  end

  resources :users
  get 'signup', to: 'users#new'

  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
end
