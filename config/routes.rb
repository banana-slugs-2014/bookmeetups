Bookmeetups::Application.routes.draw do
  root to: 'users#new'
  post "/search", to: "searches#search"
  resources :users
end
