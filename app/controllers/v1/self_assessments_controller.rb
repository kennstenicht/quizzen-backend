# frozen_string_literal: true

module V1
  # Controller for self_assessments
  class SelfAssessmentsController < ApplicationController
    before_action :set_self_assessment, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /self_assessments
    def index
      authorize SelfAssessment

      parent = find_parent(%w[played_question])
      self_assessments = parent ? parent.self_assessments : policy_scope(SelfAssessment)

      allowed = %i[assessment]

      jsonapi_filter(policy_scope(self_assessments), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /self_assessments/1
    def show
      authorize @self_assessment

      render jsonapi: @self_assessment
    end

    # POST /self_assessments
    def create
      @self_assessment = SelfAssessment.new(@params_deserialized)
      @self_assessment.quiz_master = current_user

      authorize @self_assessment

      if @self_assessment.save
        render jsonapi: @self_assessment, status: :created, location: v1_self_assessment_url(@self_assessment)
      else
        render jsonapi_errors: @self_assessment.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /self_assessments/1
    def update
      authorize @self_assessment

      if @self_assessment.update(@params_deserialized)
        render jsonapi: @self_assessment
      else
        render jsonapi_errors: @self_assessment.errors, status: :unprocessable_entity
      end
    end

    # DELETE /self_assessments/1
    def destroy
      authorize @self_assessment

      @self_assessment.destroy
    end

    private

    def set_self_assessment
      id = params[:self_assessment_id] || params[:id]

      @self_assessment = SelfAssessment.find(id)
    end

    def deserialize_params
      params_only = %i[assessment question user is_false_assessment]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end

    def jsonapi_serializer_params
      {
        current_user: current_user
      }
    end

    def jsonapi_include
      ['user']
    end
  end
end
