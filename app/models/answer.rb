# frozen_string_literal: true

# Answer model
class Answer < ApplicationRecord
  # Validations
  validates :label, presence: true

  # Relation
  belongs_to :question

  # Ransack
  ransack_alias :search, :label

  def url
    Rails.application.routes.url_helpers.v1_answers_url(id)
  end
end
