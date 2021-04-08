# frozen_string_literal: true

# Played question model
class PlayedQuestion < ApplicationRecord
  # Relation
  has_many :played_answers
  belongs_to :game
  belongs_to :guess_question, optional: true
  belongs_to :question
  has_many :self_assessments
  belongs_to :winner, class_name: 'User', optional: true

  def url
    Rails.application.routes.url_helpers.v1_played_question_url(id)
  end
end
