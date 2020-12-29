# frozen_string_literal: true

# Game question model
class GameQuestion < ApplicationRecord
  # Relation
  has_many :game_answers
  belongs_to :game
  belongs_to :question
  has_many :self_assessments
  belongs_to :winner, class_name: 'User'

  def url
    Rails.application.routes.url_helpers.v1_game_question_url(id)
  end
end
