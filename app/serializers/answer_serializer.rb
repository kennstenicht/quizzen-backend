# frozen_string_literal: true

# Serializer for answers
class AnswerSerializer < ApplicationSerializer
  # Attributes
  attributes :id, :label, :value, :information


  # Relations
  belongs_to :question, links: {
    related: lambda do |object|
      url_helpers.v1_question_url(object.id)
    end
  }
end
