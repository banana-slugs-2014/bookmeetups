Bookmeetups::Application.routes.draw do
  root to: 'users#new'
  post "/search", to: "searches#search"
  resources :users do
    post 'books/:isbn', to: 'user_books#create'
    delete 'books/:isbn', to: 'user_books#destroy'
  end

  resources :books, only: [:create, :show, :index]

  end





