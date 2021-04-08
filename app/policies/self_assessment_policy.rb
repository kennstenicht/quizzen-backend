# frozen_string_literal: true

# Self assessment policy
class SelfAssessmentPolicy < ApplicationPolicy
  # Custom self assessment scope
  class Scope < Scope
    def resolve
      scope.joins(played_question: [:game]).where(played_question: {
        games: {
          quiz_master: user.id
        }
      })
    end
  end
end
