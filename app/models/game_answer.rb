# frozen_string_literal: true

# Game answer model
class GameAnswer < ApplicationRecord
  # Relation
  belongs_to :answer
  belongs_to :game_question
  belongs_to :user

  def url
    Rails.application.routes.url_helpers.v1_game_answer_url(id)
  end
end
