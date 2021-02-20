# frozen_string_literal: true

# Quiz model
class Quiz < ApplicationRecord
  # Validations
  validates :title, presence: true

  # Relation
  has_and_belongs_to_many :categories
  belongs_to :owner, class_name: 'User'

  # Ransack
  ransack_alias :search, :title

  def url
    Rails.application.routes.url_helpers.v1_quiz_url(id)
  end
end
