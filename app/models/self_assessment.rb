# frozen_string_literal: true

# Self assessment model
class SelfAssessment < ApplicationRecord
  # Validations
  validates :assessment, presence: true

  # Relation
  belongs_to :game_question
  belongs_to :user

  def url
    Rails.application.routes.url_helpers.v1_self_assessment_url(id)
  end
end
