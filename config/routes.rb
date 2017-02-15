Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/add', to: 'users#create'
  post 'users/add', to: 'users#add'
  get 'users/login', to: 'users#login'
  post 'users/login', to: 'users#do_login'
  resources :users
end