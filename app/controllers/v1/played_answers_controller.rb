# frozen_string_literal: true

module V1
  # Controller for played_answers
  class PlayedAnswersController < ApplicationController
    before_action :set_played_answer, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /played_answers
    def index
      authorize PlayedAnswer

      parent = find_parent(%w[played_question])
      played_answers = parent ? parent.played_answers : policy_scope(PlayedAnswer)

      allowed = %i[user]

      jsonapi_filter(policy_scope(played_answers), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /played_answers/1
    def show
      authorize @played_answer

      render jsonapi: @played_answer
    end

    # POST /played_answers
    def create
      @played_answer = PlayedAnswer.new(@params_deserialized)

      authorize @played_answer

      if @played_answer.save
        render jsonapi: @played_answer, status: :created, location: v1_played_answer_url(@played_answer)
      else
        render jsonapi_errors: @played_answer.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /played_answers/1
    def update
      authorize @played_answer

      if @played_answer.update(@params_deserialized)
        render jsonapi: @played_answer
      else
        render jsonapi_errors: @played_answer.errors, status: :unprocessable_entity
      end
    end

    # DELETE /played_answers/1
    def destroy
      authorize @played_answer

      @played_answer.destroy
    end

    private

    def set_played_answer
      id = params[:played_answer_id] || params[:id]

      @played_answer = PlayedAnswer.find(id)
    end

    def deserialize_params
      params_only = %i[answer played_question user]

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
