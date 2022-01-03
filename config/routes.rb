Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, :only => [:index,:show,:destroy]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:index,:create,:show]
  
  resources :instagrams do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create,:destroy]
  end
  root 'instagrams#index'
end
