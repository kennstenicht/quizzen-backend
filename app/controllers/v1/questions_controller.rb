# frozen_string_literal: true

module V1
  # Controller for Questions
  class QuestionsController < ApplicationController
    before_action :set_question, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /questions
    def index
      authorize Question

      parent = find_parent(%w[category])
      @questions = parent ? parent.questions : Question

      allowed = %i[date name guests workspaces_id]

      jsonapi_filter(policy_scope(@questions), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /questions/1
    def show
      authorize @question

      render jsonapi: @question
    end

    # POST /questions
    def create
      @question = Question.new(@params_deserialized)
      @question.owner = current_user

      authorize @question

      if @question.save
        render jsonapi: @question, status: :created, location: v1_question_url(@question)
      else
        render jsonapi_errors: @question.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /questions/1
    def update
      authorize @question

      if @question.update(@params_deserialized)
        render jsonapi: @question
      else
        render jsonapi_errors: @question.errors, status: :unprocessable_entity
      end
    end

    # DELETE /questions/1
    def destroy
      authorize @question

      @question.destroy
    end

    private

    def set_question
      id = params[:question_id] || params[:id]

      @question = Question.find(id)
    end

    def deserialize_params
      params_only = %i[date label source]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
