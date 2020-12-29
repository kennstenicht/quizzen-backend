# frozen_string_literal: true

# Serializer for game questions
class GameQuestionSerializer < ApplicationSerializer
  # Relations
  belongs_to :game, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_question_game_url(record.id, record.game.id)
    end
  }

  has_many :game_answers, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_question_game_answers_url(record.id)
    end
  }

  belongs_to :question, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_question_question_url(record.id, record.question.id)
    end
  }

  has_many :self_assessments, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_question_self_assessments_url(record.id)
    end
  }

  belongs_to :winner, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_question_user_url(record.id, record.winner.id)
    end
  }
end
