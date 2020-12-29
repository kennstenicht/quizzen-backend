# frozen_string_literal: true

module V1
  # Controller for Categories
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /categories
    def index
      puts current_user
      authorize Category

      parent = find_parent(%w[quiz question])
      categories = parent ? parent.categories : Category

      allowed = %i[title questions_id quizzes_id]

      jsonapi_filter(policy_scope(categories), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /categories/1
    def show
      authorize @category

      render jsonapi: @category
    end

    # POST /categories
    def create
      @category = Category.new(@params_deserialized)
      @category.owner = current_user

      authorize @category

      if @category.save
        render jsonapi: @category,
               status: :created,
               location: v1_category_url(@category)
      else
        render jsonapi_errors: @category.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /categories/1
    def update
      authorize @category

      if @category.update(@params_deserialized)
        render jsonapi: @category
      else
        render jsonapi_errors: @category.errors, status: :unprocessable_entity
      end
    end

    # DELETE /categories/1
    def destroy
      authorize @category

      @category.destroy
    end

    private

    def set_category
      id = params[:category_id] || params[:id]

      @category = Category.find(id)
    end

    def deserialize_params
      params_only = %i[id title questions quizzes]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
