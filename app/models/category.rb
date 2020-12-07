# frozen_string_literal: true

# Category model
class Category < ApplicationRecord
  # Validations
  validates :title, presence: true

  # Relation
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :quizzes
  belongs_to :owner, class_name: 'User'

  def url
    Rails.application.routes.url_helpers.v1_category_url(id)
  end
end
