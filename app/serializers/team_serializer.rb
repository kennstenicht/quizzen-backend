# frozen_string_literal: true

# Serializer for team
class TeamSerializer < ApplicationSerializer
  # Attrbiutes
  attributes :name


  # Relations
  belongs_to :game, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_self_assessment_game_url(record.id, record.game.id)
    end
  }

  has_many :user, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_self_assessment_users_url(record.id)
    end
  }
end
