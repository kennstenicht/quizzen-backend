# frozen_string_literal: true

# Serializer for categories
class CategorySerializer < ApplicationSerializer
  # Attributes
  attributes :title


  # Relations
  has_many :questions, links: {
    related: lambda do |object|
      url_helpers.v1_category_questions_url(object.id)
    end
  }
  has_many :quizzes, links: {
    related: lambda do |object|
      url_helpers.v1_category_quizzes_url(object.id)
    end
  }
  belongs_to :owner, serializer: :user, links: {
    related: lambda do |object|
      url_helpers.v1_category_user_url(object.id, object.owner.id)
    end
  }
end
