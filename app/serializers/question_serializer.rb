# frozen_string_literal: true

# Serializer for events
class QuestionSerializer < ApplicationSerializer
  attributes :id, :label, :source, :date

  has_many :answers, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_question_answers_url(object.id)
    end
  }
  has_many :categories, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_question_categories_url(object.id)
    end
  }
  belongs_to :owner, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_question_user_url(object.id, object.owner.id)
    end
  }
end
