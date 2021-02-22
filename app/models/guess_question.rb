# frozen_string_literal: true

# Guess Question model
class GuessQuestion < ApplicationRecord
  # Validations
  validates :answer, :label, :source, presence: true

  # Relation
  belongs_to :owner, class_name: 'User'

  # Ransack
  ransack_alias :search, :label

  def url
    Rails.application.routes.url_helpers.v1_guess_question_url(id)
  end
end
