Rails.application.routes.draw do
  root 'sessions#home'
  get '/auth/facebook/callback' => 'sessions#oauth'
  get 'auth/failure' => 'sessions#home'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/swipe' => 'restaurants#swipe'
   
  resources :friends, only: [:index, :update, :create, :destroy]
  resources :restaurants do
    resources :photos
    resources :likes, only: [:create]
    get '/unlike' => 'likes#destroy'
  end
  resources :photos
  resources :users do
    resources :restaurants, only: [:index]
    resources :photos, only: [:show, :index, :new, :create, :destroy]
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
