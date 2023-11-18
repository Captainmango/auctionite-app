# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :lots do
    post 'bid', to: 'bid#place'
  end

  get 'auctions', to: 'lots#live_index', as: 'live_lots'

  resources :items
  root 'landing#index', as: 'landing_page'

  namespace :users, path: '/' do
    get 'registration', to: 'registration#new', as: 'new_registration'
    post 'registration', to: 'registration#register', as: 'sign_up'
    get 'sign-in', to: 'session#new', as: 'new_session'
    post 'sign-in', to: 'session#sign_in', as: 'sign_in'
    delete 'sign-out', to: 'session#sign_out', as: 'sign_out'
  end

  resources :addresses

  mount Sidekiq::Web => '/sidekiq', constraints: IsAdminConstraint

  get '*all', to: 'application#route_not_found', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
