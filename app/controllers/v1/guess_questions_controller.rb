# frozen_string_literal: true

module V1
  # Controller for Guess GuessQuestions
  class GuessQuestionsController < ApplicationController
    before_action :set_guess_question, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /guess_questions
    def index
      authorize GuessQuestion

      parent = find_parent(%w[])
      guess_questions = parent ? parent.guess_questions : GuessQuestion

      allowed = %i[label categories_id search]

      jsonapi_filter(policy_scope(guess_questions), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /guess_questions/1
    def show
      authorize @guess_question

      render jsonapi: @guess_question
    end

    # POST /guess_questions
    def create
      @guess_question = GuessQuestion.new(@params_deserialized)
      @guess_question.owner = current_user

      authorize @guess_question

      if @guess_question.save
        render jsonapi: @guess_question, status: :created, location: v1_question_url(@guess_question)
      else
        render jsonapi_errors: @guess_question.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /guess_questions/1
    def update
      authorize @guess_question

      if @guess_question.update(@params_deserialized)
        render jsonapi: @guess_question
      else
        render jsonapi_errors: @guess_question.errors, status: :unprocessable_entity
      end
    end

    # DELETE /guess_questions/1
    def destroy
      authorize @guess_question

      @guess_question.destroy
    end

    private

    def set_guess_question
      id = params[:guess_question_id] || params[:id]

      @guess_question = GuessQuestion.find(id)
    end

    def deserialize_params
      params_only = %i[id date label source answer unit]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
