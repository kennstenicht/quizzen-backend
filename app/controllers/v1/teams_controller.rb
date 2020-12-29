# frozen_string_literal: true

module V1
  # Controller for teams
  class TeamsController < ApplicationController
    before_action :set_team, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]

    # GET /teams
    def index
      authorize Team

      parent = find_parent(%w[game])
      teams = parent ? parent.teams : policy_scope(Team)

      allowed = %i[name]

      jsonapi_filter(policy_scope(teams), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /teams/1
    def show
      authorize @team

      render jsonapi: @team
    end

    # POST /teams
    def create
      @team = Team.new(@params_deserialized)
      @team.quiz_master = current_user

      authorize @team

      if @team.save
        render jsonapi: @team, status: :created, location: v1_team_url(@team)
      else
        render jsonapi_errors: @team.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /teams/1
    def update
      authorize @team

      if @team.update(@params_deserialized)
        render jsonapi: @team
      else
        render jsonapi_errors: @team.errors, status: :unprocessable_entity
      end
    end

    # DELETE /teams/1
    def destroy
      authorize @team

      @team.destroy
    end

    private

    def set_team
      id = params[:team_id] || params[:id]

      @team = Team.find(id)
    end

    def deserialize_params
      params_only = %i[name game users]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end

    def jsonapi_serializer_params
      {
        current_user: current_user
      }
    end
  end
end
