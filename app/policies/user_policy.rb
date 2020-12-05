# frozen_string_literal: true

# User Policy
class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    scope.where(id: record.id).exists?
  end

  # Custom user scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
