# frozen_string_literal: true

# Serializer for quizzes
class QuizSerializer < ApplicationSerializer
  attributes :title

  has_many :categories, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_quizze_categories_url(object.id)
    end
  }
  belongs_to :owner, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |object|
      url_helpers.v1_quizze_user_url(object.id, object.owner.id)
    end
  }
end
