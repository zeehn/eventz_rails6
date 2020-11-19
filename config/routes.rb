Rails.application.routes.draw do
  root 'events#index'
  get 'events', to: 'events#index'
  post 'events', to: 'events#create'
  get 'events/new', to: 'events#new', as: 'new_event'
  get 'events/:id', to: 'events#show', as: 'event'
  get 'events/:id/edit', to: 'events#edit', as: 'edit_event'
  patch 'events/:id', to: 'events#update'
end
