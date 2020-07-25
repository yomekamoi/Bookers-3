Rails.application.routes.draw do

	root'books#top'
	get '/home/about', to: 'books#about'
  get '/search', to: 'search#search'
  devise_for :users
  resources :books, only:[:new, :create, :index, :show, :destroy,:edit,:update] do
	  resource :favorites, only: [:create, :destroy]
	  resource :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:index, :create, :destroy]
  resources :users, only:[:new,:index,:show, :update, :edit] do
  	 member do
     get :followings, :followers
    end
  end
end
