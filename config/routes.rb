Rails.application.routes.draw do
  root 'events#index'
  get 'events', to: 'events#index'
  get 'events/:id', to: 'events#show', as: 'event'
  get 'events/:id/edit', to: 'events#edit', as: 'edit_event'
end
