# frozen_string_literal: true

# User Policy
class UserPolicy < ApplicationPolicy
  # Custom user scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
