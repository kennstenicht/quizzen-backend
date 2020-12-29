# frozen_string_literal: true

# Serializer for game answers
class GameAnswerSerializer < ApplicationSerializer
  # Relations
  belongs_to :game_question, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_answer_game_question_url(record.id, record.game_question.id)
    end
  }

  belongs_to :answer, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_answer_answer_url(record.id, record.answer.id)
    end
  }, if: proc { |record, params|
    params[:current_user] && record.game_question.game.quiz_master === params[:current_user]
  }

  belongs_to :user, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_answer_user_url(record.id, record.user.id)
    end
  }, if: proc { |record, params|
    Rails.logger.info "==================="
    Rails.logger.info record.game_question.game.quiz_master.nickname
    params[:current_user] && record.game_question.game.quiz_master === params[:current_user]
  }
end
