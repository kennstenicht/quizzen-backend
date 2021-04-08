# frozen_string_literal: true

# Played answer policy
class PlayedAnswerPolicy < ApplicationPolicy
  # Custom game answer scope
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
