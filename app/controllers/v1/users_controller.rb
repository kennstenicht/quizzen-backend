# frozen_string_literal: true

module V1
  # Controller for users
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]
    before_action :deserialize_params, only: %i[create update]
    before_action :set_invite, only: %i[create]

    # GET /users
    def index
      authorize User

      parent = find_parent(%w[])
      @users = parent ? parent.users : policy_scope(User)

      allowed = %i[firstname lastname email]

      jsonapi_filter(policy_scope(@users), allowed) do |filtered|
        jsonapi_paginate(filtered.result) do |paginated|
          render jsonapi: paginated
        end
      end
    end

    # GET /users/1
    def show
      authorize @user

      render jsonapi: @user
    end

    # POST /users
    def create
      @user = User.new(@params_deserialized)

      @user.workspaces.push(@invite.workspace) if @invite

      authorize @user

      if @user.save
        render jsonapi: @user, status: :created, location: v1_user_url(@user)
      else
        render jsonapi_errors: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      authorize @user

      if @user.update(@params_deserialized)
        render jsonapi: @user
      else
        render jsonapi_errors: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      authorize @user

      @user.destroy
    end

    private

    def set_user
      id = params[:user_id] || params[:id]

      @user = User.find(id)
    end

    def set_invite
      token = params[:data][:attributes][:'invite-token']
      email = params[:data][:attributes][:email]

      @invite = Invite.find_by(token: token, email: email) if token && email
    end

    def deserialize_params
      params_only = %i[email firstname lastname password workspaces]

      @params_deserialized = jsonapi_deserialize(params, only: params_only)
    end
  end
end
