# frozen_string_literal: true

# Question model
class Question < ApplicationRecord
  # Validations
  validates :label, :source, :date, presence: true

  # Relation
  has_many :answers
  has_and_belongs_to_many :categories
  belongs_to :owner, class_name: 'User'

  # Ransack
  ransack_alias :search, :label

  def url
    Rails.application.routes.url_helpers.v1_question_url(id)
  end
end
