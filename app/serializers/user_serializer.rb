# frozen_string_literal: true

# Serializer for venues
class UserSerializer < ApplicationSerializer
  # Attributes
  attributes :nickname, :firstname, :lastname

  attribute :email, if: proc { |record, params|
    params[:current_user] && params[:current_user].id == record.id
  }


  # Relations
  has_many :teams, links: {
    related: lambda do |record|
      url_helpers.v1_user_teams_url(record.id)
    end
  }
end
