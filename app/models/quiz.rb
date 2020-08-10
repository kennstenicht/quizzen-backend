# frozen_string_literal: true

# Quiz model
class Quiz < ApplicationRecord
  # Relation
  has_and_belongs_to_many :categories
  belongs_to :owner, class_name: 'User'

  def url
    Rails.application.routes.url_helpers.v1_quizze_url(id)
  end
end
