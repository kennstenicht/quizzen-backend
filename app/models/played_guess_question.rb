# frozen_string_literal: true

# Played guess question model
class PlayedGuessQuestion < ApplicationRecord
  # Relation
  belongs_to :game
  belongs_to :guess_question
  belongs_to :played_question, optional: true
  has_many :played_guess_question_answers, dependent: :destroy
  belongs_to :winner, class_name: 'User', optional: true

  def url
    Rails.application.routes.url_helpers.v1_played_guess_question_url(id)
  end
end
