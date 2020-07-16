# frozen_string_literal: true

# Controller for Answers
class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show update destroy]
  before_action :deserialize_params, only: %i[create update]

  # GET /answers
  def index
    authorize Answer

    parent = find_parent(%w[])
    @answers = parent ? parent.answers : Answer

    allowed = %i[label value information question_id]

    jsonapi_filter(policy_scope(@answers), allowed) do |filtered|
      jsonapi_paginate(filtered.result) do |paginated|
        render jsonapi: paginated
      end
    end
  end

  # GET /answers/1
  def show
    authorize @answer

    render jsonapi: @answer
  end

  # POST /answers
  def create
    @answer = Answer.new(@params_deserialized)

    authorize @answer

    if @answer.save
      render jsonapi: @answer, status: :created, location: answer_url(@answer)
    else
      render jsonapi_errors: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /answers/1
  def update
    authorize @answer

    if @answer.update(@params_deserialized)
      render jsonapi: @answer
    else
      render jsonapi_errors: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1
  def destroy
    authorize @answer

    @answer.destroy
  end

  private

  def set_answer
    id = params[:answer_id] || params[:id]

    @answer = Answer.find(id)
  end

  def deserialize_params
    params_only = %i[artists date guests name workspaces]

    @params_deserialized = jsonapi_deserialize(params, only: params_only)
  end

  # Overwrite/whitelist the includes
  def jsonapi_include
    super & ['artists', 'venue']
  end
end
