Rails.application.routes.draw do
  get 'book_comments/create'
  get 'book_comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  root 'home#top'
  get 'home/about' => 'home#about'
  devise_for :users
  resources :users ,only: [:show,:index,:edit,:update]
  resources :books do
  	resource :favorites, only: [:create,:destroy]
    resources :book_comments, only: [:create]
  end
  resources :book_comments, only: [:destroy]
end