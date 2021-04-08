# frozen_string_literal: true

module V1
  # Controller for played_questions
  class PlayedQuestionsController < ApplicationController
    before_action :set_played_question, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /played_questions
    def index
      authorize PlayedQuestion

      parent = find_parent(%w[game])
      played_questions = parent ? parent.played_questions : policy_scope(PlayedQuestion)

      allowed = %i[quiz_master]

      jsonapi_filter(policy_scope(played_questions), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /played_questions/1
    def show
      authorize @played_question

      render jsonapi: @played_question
    end

    # POST /played_questions
    def create
      @played_question = PlayedQuestion.new(@params_deserialized)

      authorize @played_question

      if @played_question.save
        render jsonapi: @played_question, status: :created, location: v1_played_question_url(@played_question)
      else
        render jsonapi_errors: @played_question.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /played_questions/1
    def update
      authorize @played_question

      if @played_question.update(@params_deserialized)
        render jsonapi: @played_question
      else
        render jsonapi_errors: @played_question.errors, status: :unprocessable_entity
      end
    end

    # DELETE /played_questions/1
    def destroy
      authorize @played_question

      @played_question.destroy
    end

    private

    def set_played_question
      id = params[:played_question_id] || params[:id]

      @played_question = PlayedQuestion.find(id)
    end

    def deserialize_params
      params_only = %i[id game played_answers guess_question question winner]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end

    def jsonapi_serializer_params
      {
        current_user: current_user
      }
    end

    def jsonapi_include
      ['question', 'played_answers', 'self_assessments']
    end
  end
end
