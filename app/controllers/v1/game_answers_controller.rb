# frozen_string_literal: true

module V1
  # Controller for game_answers
  class GameAnswersController < ApplicationController
    before_action :set_game_answer, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /game_answers
    def index
      authorize GameAnswer

      parent = find_parent(%w[game_question])
      game_answers = parent ? parent.game_answers : policy_scope(GameAnswer)

      allowed = %i[quiz_master]

      jsonapi_filter(policy_scope(game_answers), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /game_answers/1
    def show
      authorize @game_answer

      render jsonapi: @game_answer
    end

    # POST /game_answers
    def create
      @game_answer = GameAnswer.new(@params_deserialized)
      @game_answer.quiz_master = current_user

      authorize @game_answer

      if @game_answer.save
        render jsonapi: @game_answer, status: :created, location: v1_game_answer_url(@game_answer)
      else
        render jsonapi_errors: @game_answer.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /game_answers/1
    def update
      authorize @game_answer

      if @game_answer.update(@params_deserialized)
        render jsonapi: @game_answer
      else
        render jsonapi_errors: @game_answer.errors, status: :unprocessable_entity
      end
    end

    # DELETE /game_answers/1
    def destroy
      authorize @game_answer

      @game_answer.destroy
    end

    private

    def set_game_answer
      id = params[:game_answer_id] || params[:id]

      @game_answer = GameAnswer.find(id)
    end

    def deserialize_params
      params_only = %i[answer game_question user]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end

    def jsonapi_serializer_params
      {
        current_user: current_user
      }
    end

    def jsonapi_include
      ['answer', 'user']
    end
  end
end
