Bookmeetups::Application.routes.draw do
  root to: 'users#landing'

  post "/search", to: "searches#search"
  get "users/landing", to: "users#landing"
  resources :users do
    post 'books/:book_id', to: 'favorite_books#create', as: 'create_favorite_book'
    delete 'books/:book_id', to: 'favorite_books#destroy', as: 'favorite_book'
    get 'books', to: 'favorite_books#index', as: 'favorite_books'
    get 'books/:book_id/new_meetup', to: 'meetups#create', as: 'create_meetup'
    resources :meetups, :except => [:new, :edit, :create, :destroy]
    resources :photos, :only => [:show, :new, :create, :destroy] do
      get "serve", :on => :member
    end
  end

  resources :books, only: [:create, :show, :index]
  resources :sessions, :only => [:new, :create, :destroy]

  resources :meetups, :only => [] do
    resources :messages, only: [:new, :create]
  end


  get "/search/:s", to: "searches#results"
  get "/search", to: "searches#results"
end
