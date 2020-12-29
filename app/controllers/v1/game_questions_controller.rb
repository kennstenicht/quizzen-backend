# frozen_string_literal: true

module V1
  # Controller for game_questions
  class GameQuestionsController < ApplicationController
    before_action :set_game_question, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /game_questions
    def index
      authorize GameQuestion

      parent = find_parent(%w[game])
      game_questions = parent ? parent.game_questions : policy_scope(GameQuestion)

      allowed = %i[quiz_master]

      jsonapi_filter(policy_scope(game_questions), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /game_questions/1
    def show
      authorize @game_question

      render jsonapi: @game_question
    end

    # POST /game_questions
    def create
      @game_question = GameQuestion.new(@params_deserialized)
      @game_question.quiz_master = current_user

      authorize @game_question

      if @game_question.save
        render jsonapi: @game_question, status: :created, location: v1_game_question_url(@game_question)
      else
        render jsonapi_errors: @game_question.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /game_questions/1
    def update
      authorize @game_question

      if @game_question.update(@params_deserialized)
        render jsonapi: @game_question
      else
        render jsonapi_errors: @game_question.errors, status: :unprocessable_entity
      end
    end

    # DELETE /game_questions/1
    def destroy
      authorize @game_question

      @game_question.destroy
    end

    private

    def set_game_question
      id = params[:game_question_id] || params[:id]

      @game_question = GameQuestion.find(id)
    end

    def deserialize_params
      params_only = %i[game game_answers question winner]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end

    def jsonapi_serializer_params
      {
        current_user: current_user
      }
    end

    def jsonapi_include
      ['question', 'game_answers', 'self_assessments']
    end
  end
end
