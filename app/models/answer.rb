# frozen_string_literal: true

# Answer model
class Answer < ApplicationRecord
  # Validations
  validates :label, presence: true

  # Relation
  belongs_to :question

  def url
    Rails.application.routes.url_helpers.v1_answers_url(id)
  end
end
