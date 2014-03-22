Bookmeetups::Application.routes.draw do
  root to: 'users#new'

  post "/search", to: "searches#search"
  resources :users do
    post 'books/:book_id', to: 'user_books#create'
    delete 'books/:book_id', to: 'user_books#destroy'
    get 'books/', to: 'user_books#index'
    resources :meetups, :except => [:new, :edit, :destroy]
  end

  resources :books, only: [:create, :show, :index]
  resources :sessions, :only => [:new, :create, :destroy]

  resources :meetups, :only => [] do
    resources :messages, only: [:new, :create]
  end


  get "/search/:s", to: "searches#results"
  get "/search", to: "searches#results"
end
