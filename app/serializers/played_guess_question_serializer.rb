# frozen_string_literal: true

# Serializer for played guess questions
class PlayedGuessQuestionSerializer < ApplicationSerializer
  # Relations
  belongs_to :guess_question, links: {
    related: lambda do |record|
      url_helpers.v1_guess_question_url(record.id, record.guess_question.id)
    end
  }, if: proc { |record, params|
    record.guess_question
  }

  has_many :played_guess_question_answers, links: {
    related: lambda do |record|
      url_helpers.v1_game_played_guess_question_answers_url(record.id)
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
