# frozen_string_literal: true

# Serializer for venues
class UserSerializer < ApplicationSerializer
  attributes :nickname, :firstname, :lastname

  attribute :email, if: proc { |record, params|
    params[:current_user] && params[:current_user].id == record.id
  }
end
