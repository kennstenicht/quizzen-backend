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
    resources :games do
      resources :played_guess_questions, only: %i[index]
      resources :played_questions, only: %i[index]
      resources :quizzes, only: %i[show]
      resources :users, only: %i[index show]
      resources :teams, only: %i[index]
    end
    resources :guess_questions do
      resources :games, only: %i[index]
      resources :played_questions, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :played_answers do
      resources :answers, only: %i[show]
      resources :played_questions, only: %i[show]
      resources :users, only: %i[show]
    end
    resources :played_guess_question_answers do
      resources :users, only: %i[show]
      resources :played_guess_questions, only: %i[show]
    end
    resources :played_guess_questions do
      resources :game, only: %i[show]
      resources :guess_question, only: %i[show]
      resources :played_questioj, only: %i[show]
      resources :played_guess_question_answers, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :played_questions do
      resources :games, only: %i[show]
      resources :played_answers, only: %i[index]
      resources :played_guess_questions, only: %i[show]
      resources :questions, only: %i[show]
      resources :self_assessments, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :quizzes do
      resources :categories, only: %i[index]
      resources :categories_quizzes, only: %i[index]
      resources :games, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :questions do
      resources :answers, only: %i[index]
      resources :categories, only: %i[index]
      resources :users, only: %i[show]
    end
    resources :self_assessments do
      resources :played_questions, only: %i[show]
      resources :users, only: %i[show]
    end
    resources :teams do
      resources :games, only: %i[show]
      resources :users, only: %i[index]
    end
    resources :users do
      resources :teams, only: %i[index]
    end
  end
end
