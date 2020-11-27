# frozen_string_literal: true

# Serializer for categories
class CategorySerializer < ApplicationSerializer
  attributes :title

  has_many :questions, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_category_questions_url(object.id)
    end
  }
  has_many :quizzes, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_category_quizzes_url(object.id)
    end
  }
  belongs_to :owner, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_category_user_url(object.id, object.owner.id)
    end
  }
end
