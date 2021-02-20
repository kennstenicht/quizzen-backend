# frozen_string_literal: true

module V1
  # Controller for Quizzes
  class QuizzesController < ApplicationController
    before_action :set_quiz, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /quizzes
    def index
      authorize Quiz

      parent = find_parent(%w[category])
      quizzes = parent ? parent.quizzes : Quiz

      allowed = %i[title categories_id search]

      jsonapi_filter(policy_scope(quizzes), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /quizzes/1
    def show
      authorize @quiz

      render jsonapi: @quiz
    end

    # POST /quizzes
    def create
      @quiz = Quiz.new(@params_deserialized)
      @quiz.owner = current_user

      authorize @quiz

      if @quiz.save
        render jsonapi: @quiz,
               status: :created,
               location: v1_quiz_url(@quiz)
      else
        render jsonapi_errors: @quiz.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /quizzes/1
    def update
      authorize @quiz

      if @quiz.update(@params_deserialized)
        render jsonapi: @quiz
      else
        render jsonapi_errors: @quiz.errors, status: :unprocessable_entity
      end
    end

    # DELETE /quizzes/1
    def destroy
      authorize @quiz

      @quiz.destroy
    end

    private

    def set_quiz
      id = params[:quiz_id] || params[:id]

      @quiz = Quiz.find(id)
    end

    def deserialize_params
      params_only = %i[id title categories]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
