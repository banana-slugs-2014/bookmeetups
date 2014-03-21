Bookmeetups::Application.routes.draw do
  root to: 'users#new'
  post "/search", to: "searches#search"
  get "/search", to: "searches#index"
  resources :users
end
