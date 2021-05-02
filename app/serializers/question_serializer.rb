# frozen_string_literal: true

# Serializer for question
class QuestionSerializer < ApplicationSerializer
  # Attributes
  attributes :id, :label, :source, :date


  # Relations
  has_many :answers, links: {
    related: lambda do |object|
      url_helpers.v1_question_answers_url(object.id)
    end
  }

  has_many :categories, links: {
    related: lambda do |object|
      url_helpers.v1_question_categories_url(object.id)
    end
  }

  belongs_to :owner, serializer: :user, links: {
    related: lambda do |object|
      url_helpers.v1_question_user_url(object.id, object.owner.id)
    end
  }
end
