# frozen_string_literal: true

# Self assessment policy
class SelfAssessmentPolicy < ApplicationPolicy
  # Custom self assessment scope
  class Scope < Scope
    def resolve
      scope.joins(game_question: [:game]).where(game_question: {
        games: {
          quiz_master: user.id
        }
      })
    end
  end
end
