# frozen_string_literal: true

# Game Policy
class GamePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    scope.where(id: record.id).exists?
  end

  # Custom user scope
  class Scope < Scope
    def resolve
      if user
        scope.includes(:users)
          .where(
            'active=true OR quiz_master_id=? OR users.id=?',
            user.id,
            user.id
          )
          .references(:users)
      else
        scope.active
      end
    end
  end
end
