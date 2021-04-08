# frozen_string_literal: true

# Serializer for played answers
class PlayedAnswerSerializer < ApplicationSerializer
  # Relations
  belongs_to :played_question, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_played_answer_played_question_url(record.id, record.played_question.id)
    end
  }

  belongs_to :answer, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_played_answer_answer_url(record.id, record.answer.id)
    end
  }, if: proc { |record, params|
    params[:current_user] && record.played_question.game.quiz_master === params[:current_user]
  }

  belongs_to :user, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_played_answer_user_url(record.id, record.user.id)
    end
  }, if: proc { |record, params|
    params[:current_user] && record.played_question.game.quiz_master === params[:current_user]
  }
end
