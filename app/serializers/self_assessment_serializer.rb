# frozen_string_literal: true

# Serializer for self assessment
class SelfAssessmentSerializer < ApplicationSerializer
  # Attrbiutes
  attributes :assessment, :is_false_assessment


  # Relations
  belongs_to :played_question, links: {
    related: lambda do |record|
      url_helpers.v1_self_assessment_played_question_url(record.id, record.played_question.id)
    end
  }

  belongs_to :user, links: {
    related: lambda do |record|
      url_helpers.v1_self_assessment_user_url(record.id, record.user.id)
    end
  }
end
