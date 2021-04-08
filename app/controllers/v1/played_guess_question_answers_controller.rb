# frozen_string_literal: true

module V1
  # Controller for played_guess_questions
  class PlayedGuessQuestionAnswerAnswersController < ApplicationController
    before_action :set_record, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /played_guess_question_answers
    def index
      authorize PlayedGuessQuestionAnswer

      parent = find_parent(%w[played_guess_question])
      records = policy_scope(PlayedGuessQuestionAnswer)
      records = parent.v1_played_guess_question_answers if parent

      allowed = %i[answer]

      jsonapi_filter(policy_scope(records), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /played_guess_question_answers/1
    def show
      authorize @record

      render jsonapi: @record
    end

    # POST /played_guess_question_answers
    def create
      @record = PlayedGuessQuestionAnswer.new(@params_deserialized)

      authorize @record

      if @record.save
        render jsonapi: @record, status: :created, location: v1_played_guess_question_answer_url(@record)
      else
        render jsonapi_errors: @record.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /played_guess_question_answers/1
    def update
      authorize @record

      if @record.update(@params_deserialized)
        render jsonapi: @record
      else
        render jsonapi_errors: @record.errors, status: :unprocessable_entity
      end
    end

    # DELETE /played_guess_question_answers/1
    def destroy
      authorize @record

      @record.destroy
    end

    private

    def set_record
      id = params[:played_guess_question_answer_id] || params[:id]

      @record = PlayedGuessQuestionAnswer.find(id)
    end

    def deserialize_params
      params_only = %i[id guess_question winner]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end

    def jsonapi_serializer_params
      {
        current_user: current_user
      }
    end
  end
end
