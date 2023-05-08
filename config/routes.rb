# frozen_string_literal: true

Rails.application.routes.draw do
  resources :lots do
    post 'bid', to: 'bid#place'
  end

  get 'auctions', to: 'lots#live_index', as: 'live_lots'

  resources :items
  root 'landing#index', as: 'landing_page'

  get 'registration', action: 'new', controller: 'registration', as: 'new_user'
  post 'registration', action: 'register', controller: 'registration', as: 'sign_up'
  get 'sign-in', action: 'new', controller: 'session', as: 'new_session'
  post 'sign-in', action: 'sign_in', controller: 'session', as: 'sign_in'
  delete 'sign-out', action: 'sign_out', controller: 'session', as: 'sign_out'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
