# frozen_string_literal: true

# Serializer for guess question
class GuessQuestionSerializer < ApplicationSerializer
  set_type :guess_question

  # Attributes
  attributes :id, :answer, :date, :label, :source, :unit


  # Relations
  belongs_to :owner, serializer: :user, links: {
    related: lambda do |object|
      url_helpers.v1_guess_question_user_url(object.id, object.owner.id)
    end
  }
end
