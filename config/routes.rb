# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index'

  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  resources :user_parties, only: [:create]

  resources :users, only: %i[show create] do
    get '/discover', to: 'users#discover'
    resources :movies, controller: 'user_movies', only: %i[index show] do
      resources :viewing_party, controller: 'parties', only: %i[create new]
    end
  end
end
