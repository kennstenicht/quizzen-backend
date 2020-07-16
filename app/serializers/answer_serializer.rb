# frozen_string_literal: true

# Serializer for answers
class AnswerSerializer < ApplicationSerializer
  attributes :id, :label, :value, :information

  belongs_to :question, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_question_url(object.id)
    end
  }
end
