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
        scope
          .joins(:players)
          .where(
            'active = ? OR quiz_master_id = ? OR games_users.user_id = ?',
            true, user.id, user.id
          )
      else
        scope.where(active: true)
      end
    end
  end
end
