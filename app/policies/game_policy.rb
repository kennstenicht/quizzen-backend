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
        scope.joins(:players).active.or(scope.quiz_master_is(user)).or(scope.player_is(user))
      else
        scope.active
      end
    end
  end
end
