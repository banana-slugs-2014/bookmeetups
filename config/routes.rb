Bookmeetups::Application.routes.draw do
  root to: 'users#new'
  post "/search", to: "searches#search"
  resources :users do
    post 'books/:book_id', to: 'userbooks#create'
    delete 'books/:book_id', to: 'userbooks#destroy'
  end

  resources :books, only: [:create, :show, :index]
end


