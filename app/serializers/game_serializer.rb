# frozen_string_literal: true

# Serializer for games
class GameSerializer < ApplicationSerializer
  attributes :title, :active

  attribute :joined do |record, params|
    record.players.include?(params[:current_user])
  end

  belongs_to :quiz, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_quiz_url(record.id, record.quiz.id)
    end
  }, if: proc { |record, params|
    params[:current_user] && record.quiz_master === params[:current_user]
  }

  belongs_to :quiz_master, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_user_url(record.id, record.quiz_master.id)
    end
  }

  has_many :players, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_users_url(record.id)
    end
  }, if: proc { |record, params|
    is_player = record.players.include?(params[:current_user])
    is_quiz_master = record.quiz_master === params[:current_user]

    params[:current_user] && (is_player || is_quiz_master)
  }
end
