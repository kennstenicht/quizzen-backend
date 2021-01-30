# frozen_string_literal: true

# Quiz Team
class TeamPolicy < ApplicationPolicy
  # Custom game question scope
  class Scope < Scope
    def resolve
      scope.includes(game: [:users])
        .where(
          'quiz_master_id=? OR users.id=?',
          user.id,
          user.id
        )
        .references(:game)
    end
  end
end
