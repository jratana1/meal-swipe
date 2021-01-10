Rails.application.routes.draw do
  root 'sessions#home'
  get '/auth/facebook/callback' => 'sessions#oauth'
  get 'auth/failure' => 'sessions#home'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
  resources :restaurants
  resources :likes
  resources :photos
  resources :users do
    resources :restaurants
    resources :photos
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
