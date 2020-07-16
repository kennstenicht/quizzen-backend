# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    post 'user_token' => 'user_token#create'

    resources :questions do
      resources :answers
    end
    resources :users
  end
end
