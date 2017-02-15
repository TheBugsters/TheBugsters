Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Users controller
  get 'users/add', to: 'users#create'
  post 'users/add', to: 'users#add'
  get 'users/login', to: 'users#login'
  post 'users/login', to: 'users#do_login'
  get 'users/logout', to: 'users#logout'

  # Tickets controller
  get 'tickets/new', to:'tickets#create'
  post 'tickets/new', to:'tickets#add'
  get 'tickets/:id(.:format)', to:'tickets#show'
  get 'tickets(.:format)', to:'tickets#index'

  root 'users#login'
  resources :users
  resources :tickets
end