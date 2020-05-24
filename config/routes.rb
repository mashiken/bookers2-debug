Rails.application.routes.draw do
  root 'home#top'
  get 'home/about' => 'home#about'

  devise_for :users

  resources :users ,only: [:show,:index,:edit,:update]
  get 'users/:id/follows' => 'relationships#follows_user_show', as: 'follows'
  get 'users/:id/follower' => 'relationships#follower_user_show', as: 'follower'
  post 'follow/:id' => 'relationships#create', as: 'follow' #フォローする
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow' #フォローを外す

  resources :books do
  	resource :favorites, only: [:create,:destroy]
    resources :book_comments, only: [:create]
  end
  resources :book_comments, only: [:destroy]
  get "search" => "searchs#search"
end