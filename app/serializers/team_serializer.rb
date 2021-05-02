# frozen_string_literal: true

# Serializer for team
class TeamSerializer < ApplicationSerializer
  # Attrbiutes
  attributes :name


  # Relations
  belongs_to :game, links: {
    related: lambda do |record|
      url_helpers.v1_team_game_url(record.id, record.game.id)
    end
  }

  has_many :users, links: {
    related: lambda do |record|
      url_helpers.v1_team_users_url(record.id)
    end
  }
end
