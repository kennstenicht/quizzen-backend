# frozen_string_literal: true

# Played guess question policy
class PlayedGuessQuestionPolicy < ApplicationPolicy
  # Custom played guess question scope
  class Scope < Scope
    def resolve
      scope.joins(:game).where(game: { quiz_master: user.id })
    end
  end
end
