Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/add', to: 'users#create'
  post 'users/add', to: 'users#add'
  get 'users/login', to: 'users#login'
  post 'users/login', to: 'users#do_login'


  get 'ticket/new', to:'ticket#new'
  post 'ticket/new', to:'ticket#create'
  get 'ticket/:id(.:format)', to:'ticket#show'
  get 'tickets(.:format)', to:'ticket#index'

  get 'ticket(.:format)', to:'ticket#index'
  root 'users#login'
  resources :users
  resources :ticket
end