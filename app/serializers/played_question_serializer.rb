# frozen_string_literal: true

# Serializer for game questions
class PlayedQuestionSerializer < ApplicationSerializer
  # Relations
  belongs_to :game, links: {
    related: lambda do |record|
      url_helpers.v1_played_question_game_url(record.id, record.game.id)
    end
  }

  has_many :played_answers, links: {
    related: lambda do |record|
      url_helpers.v1_played_question_played_answers_url(record.id)
    end
  }

  has_many :played_guess_questions, links: {
    related: lambda do |record|
      url_helpers.v1_game_played_guess_questions_url(record.id)
    end
  }

  belongs_to :question, links: {
    related: lambda do |record|
      url_helpers.v1_played_question_question_url(record.id, record.question.id)
    end
  }

  has_many :self_assessments, links: {
    related: lambda do |record|
      url_helpers.v1_played_question_self_assessments_url(record.id)
    end
  }

  belongs_to :winner, serializer: :user, links: {
    related: lambda do |record|
      url_helpers.v1_played_question_user_url(record.id, record.winner.id)
    end
  }, if: proc { |record, params|
    record.winner
  }
end
