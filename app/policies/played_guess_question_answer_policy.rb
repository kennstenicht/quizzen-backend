# frozen_string_literal: true

# Played guess question answer policy
class PlayedGuessQuestionAnswerPolicy < ApplicationPolicy
  # Custom played guess question answer scope
  class Scope < Scope
    def resolve
      scope.joins(played_guess_question: [:game]).where(played_guess_question: {
        games: {
          quiz_master: user.id
        }
      })
    end
  end
end
