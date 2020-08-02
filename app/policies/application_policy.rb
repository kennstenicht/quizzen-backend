# frozen_string_literal: true

# Base application policy
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    user
  end

  def new?
    create?
  end

  def update?
    user
  end

  def edit?
    update?
  end

  def destroy?
    user
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  # Base application scope
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(owner: user.id)
    end
  end
end
