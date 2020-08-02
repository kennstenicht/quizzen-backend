# frozen_string_literal: true

# Serializer for games
class GameSerializer < ApplicationSerializer
  attributes :title

  has_many :categories, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_game_categories_url(object.id)
    end
  }
  belongs_to :owner, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_game_user_url(object.id, object.owner.id)
    end
  }
end
