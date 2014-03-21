Bookmeetups::Application.routes.draw do
  root to: 'users#new'

  resources :users
  resources :books, only: [:create, :show, :index]
end
