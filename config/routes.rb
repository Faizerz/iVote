Rails.application.routes.draw do
  resources :followers, only: [:index, :create]
  resources :polls, :users
  resources :votes, only: [:create]

  root "polls#index"


  get '/login', to: 'sessions#new'#form
  post '/sessions', to: 'sessions#create' #log the user in
  get '/logout', to: 'sessions#destroy'

end
