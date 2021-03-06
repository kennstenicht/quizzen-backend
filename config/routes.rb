# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    post 'user_token' => 'user_token#create'

    resources :answers
    resources :categories do
      resources :quizzes, only: %i[index]
      resources :questions, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :game_answers do
      resources :answers, only: %i[show]
      resources :users, only: %i[show]
      resources :game_questions, only: %i[show]
    end
    resources :game_questions do
      resources :games, only: %i[show]
      resources :game_answers, only: %i[index]
      resources :guess_questions, only: %i[show]
      resources :questions, only: %i[show]
      resources :self_assessments, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :games do
      resources :game_questions, only: %i[index]
      resources :guess_questions, only: %i[show]
      resources :quizzes, only: %i[show]
      resources :users, only: %i[index show]
      resources :teams, only: %i[index]
    end
    resources :guess_questions do
      resources :games, only: %i[index]
      resources :game_questions, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :quizzes do
      resources :games, only: %i[index]
      resources :categories, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :questions do
      resources :answers, only: %i[index]
      resources :categories, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :self_assessments do
      resources :game_questions, only: %i[show]
      resources :users, only: %i[show]
    end
    resources :teams do
      resources :games, only: %i[show]
      resources :users, only: %i[index]
    end
    resources :users
  end
end
