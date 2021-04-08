# frozen_string_literal: true

# Played question policy
class PlayedQuestionPolicy < ApplicationPolicy
  # Custom game question scope
  class Scope < Scope
    def resolve
      scope.joins(:game).where(game: { quiz_master: user.id })
    end
  end
end
