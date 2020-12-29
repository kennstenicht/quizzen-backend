# frozen_string_literal: true

# Serializer for self assessment
class SelfAssessmentSerializer < ApplicationSerializer
  # Attrbiutes
  attributes :assessment


  # Relations
  belongs_to :game_question, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_self_assessment_game_question_url(record.id, record.game_question.id)
    end
  }

  belongs_to :user, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_self_assessment_user_url(record.id, record.user.id)
    end
  }
end
