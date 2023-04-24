# frozen_string_literal: true

Rails.application.routes.draw do
  root 'landing#index', as: 'landing_page'
  get 'registration', action: 'new', controller: 'registration', as: 'new_user'
  post 'registration', action: 'register', controller: 'registration', as: 'sign_up'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
