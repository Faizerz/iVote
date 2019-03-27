Rails.application.routes.draw do
  resources :followers, only: [:show, :create]
  resources :polls, :users
  resources :votes, only: [:create]
  resources :comments, only: [:create]

  root "polls#index"


  get '/login', to: 'sessions#new'#form
  post '/sessions', to: 'sessions#create' #log the user in
  get '/logout', to: 'sessions#destroy'
  get '/users/:id/leaderboard', to: 'users#leaderboard', as: 'leaderboard'

end
