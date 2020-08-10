# frozen_string_literal: true

# Quiz model
class Category < ApplicationRecord
  # Relation
  has_and_belongs_to_many :questions
  belongs_to :owner, class_name: 'User'

  def url
    Rails.application.routes.url_helpers.v1_category_url(id)
  end
end
