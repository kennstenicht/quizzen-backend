# frozen_string_literal: true

# Game answer policy
class GameAnswerPolicy < ApplicationPolicy
  # Custom game answer scope
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
