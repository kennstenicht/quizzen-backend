# frozen_string_literal: true

# Serializer for games
class GameSerializer < ApplicationSerializer
  attributes :title, :active

  belongs_to :quiz, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_game_quiz_url(object.id, object.quiz.id)
    end
  }

  belongs_to :quiz_master, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_game_user_url(object.id, object.quiz_master.id)
    end
  }

  has_many :players, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_game_users_url(object.id)
    end
  }
end
