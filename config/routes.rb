# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    post 'user_token' => 'user_token#create'

    resources :answers
    resources :questions
    resources :users
  end
end
