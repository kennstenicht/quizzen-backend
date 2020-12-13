# frozen_string_literal: true

module V1
  # Controller for games
  class GamesController < ApplicationController
    before_action :set_game, only: %i[show update destroy join]
    before_action :deserialize_params, only: %i[create update]

    # GET /games
    def index
      authorize Game

      parent = find_parent(%w[quiz])
      games = parent ? parent.games : policy_scope(Game)

      allowed = %i[quiz_master]

      jsonapi_filter(policy_scope(games), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /games/1
    def show
      authorize @game

      render jsonapi: @game
    end

    # POST /games
    def create
      @game = Game.new(@params_deserialized)
      @game.quiz_master = current_user

      authorize @game

      if @game.save
        render jsonapi: @game, status: :created, location: v1_game_url(@game)
      else
        render jsonapi_errors: @game.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /games/1
    def update
      authorize @game

      if @game.update(@params_deserialized)
        render jsonapi: @game
      else
        render jsonapi_errors: @game.errors, status: :unprocessable_entity
      end
    end

    # DELETE /games/1
    def destroy
      authorize @game

      @game.destroy
    end

    def join
      authorize @game

      user = current_user
      @game.players.push(user) unless @game.players.include?(user)

      render jsonapi: @game
    end

    private

    def set_game
      id = params[:game_id] || params[:id]

      @game = Game.find(id)
    end

    def deserialize_params
      params_only = %i[title password quiz_master quiz]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
