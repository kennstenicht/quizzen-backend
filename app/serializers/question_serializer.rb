# frozen_string_literal: true

# Serializer for events
class QuestionSerializer < ApplicationSerializer
  attributes :id, :label, :source, :date

  has_many :answers, lazy_load_data: true, links: {
    self: :url,
    related: lambda do
      url_helpers.answers_url
    end
  }
end
