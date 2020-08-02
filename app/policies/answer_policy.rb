# frozen_string_literal: true

# Answer Policy
class AnswerPolicy < ApplicationPolicy
  # Custom answer scope
  class Scope < Scope
    def resolve
      scope.joins(:question).where(questions: { owner: user.id })
    end
  end
end
