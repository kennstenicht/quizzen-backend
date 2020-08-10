# frozen_string_literal: true

module V1
  # Controller for Quizzes
  class QuizzesController < ApplicationController
    before_action :set_quizze, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /quizzes
    def index
      authorize Quiz

      parent = find_parent(%w[])
      @quizzes = parent ? parent.quizzes : Quiz

      allowed = %i[title categories_id]

      jsonapi_filter(policy_scope(@quizzes), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /quizzes/1
    def show
      authorize @quizze

      render jsonapi: @quizze
    end

    # POST /quizzes
    def create
      @quizze = Quiz.new(@params_deserialized)
      @quizze.owner = current_user

      authorize @quizze

      if @quizze.save
        render jsonapi: @quizze,
               status: :created,
               location: v1_quizze_url(@quizze)
      else
        render jsonapi_errors: @quizze.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /quizzes/1
    def update
      authorize @quizze

      if @quizze.update(@params_deserialized)
        render jsonapi: @quizze
      else
        render jsonapi_errors: @quizze.errors, status: :unprocessable_entity
      end
    end

    # DELETE /quizzes/1
    def destroy
      authorize @quizze

      @quizze.destroy
    end

    private

    def set_quizze
      id = params[:quizze_id] || params[:id]

      @quizze = Quiz.find(id)
    end

    def deserialize_params
      params_only = %i[title]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
