# frozen_string_literal: true

# Serializer for quizzes
class QuizSerializer < ApplicationSerializer
  # Attrbiutes
  attributes :title


  # Relations
  has_many :categories, links: {
    related: lambda do |object|
      url_helpers.v1_quiz_categories_url(object.id)
    end
  }

  belongs_to :owner, serializer: :user, links: {
    related: lambda do |object|
      url_helpers.v1_quiz_user_url(object.id, object.owner.id)
    end
  }
end
