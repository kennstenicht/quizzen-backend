# frozen_string_literal: true

# Category model
class Category < ApplicationRecord
  # Validations
  validates :title, presence: true

  # Relation
  has_many :categories_questions, dependent: :destroy
  has_many :questions, through: :categories_questions
  has_many :categories_quizzes, dependent: :destroy
  has_many :quizzes, through: :categories_quizzes
  belongs_to :owner, class_name: 'User'

  # Ransack
  ransack_alias :search, :title

  def url
    Rails.application.routes.url_helpers.v1_category_url(id)
  end
end
