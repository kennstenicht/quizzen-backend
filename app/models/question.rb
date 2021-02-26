# frozen_string_literal: true

# Question model
class Question < ApplicationRecord
  # Validations
  validates :label, :source, :date, presence: true

  # Relation
  has_many :answers
  has_many :categories_questions, dependent: :destroy
  has_many :categories, through: :categories_questions
  belongs_to :owner, class_name: 'User'

  # Ransack
  ransack_alias :search, :label

  def url
    Rails.application.routes.url_helpers.v1_question_url(id)
  end
end
