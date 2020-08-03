# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    post 'user_token' => 'user_token#create'

    resources :answers
    resources :categories do
      resources :questions, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :games do
      resources :categories, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :questions do
      resources :answers, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :users
  end
end
