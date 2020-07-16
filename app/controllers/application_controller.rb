# frozen_string_literal: true

# Base application controller
class ApplicationController < ActionController::API
  include JSONAPI::Deserialization
  include JSONAPI::Fetching
  include JSONAPI::Filtering
  include JSONAPI::Pagination
  include Knock::Authenticable
  include Pundit

  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    head :forbidden
  end

  def find_parent(klasses)
    klass = klasses.detect { |pk| params[:"#{pk}_id"].present? }

    @scope = klass.camelize.constantize.find(params[:"#{klass}_id"]) if klass
  end

  def jsonapi_meta(resources)
    meta = {}
    pagination = jsonapi_pagination_meta(resources)

    meta[:pagination] = pagination if pagination.present?

    if resources.respond_to?(:unscope)
      meta[:total] = resources.unscope(:limit, :offset).count
    end

    meta
  end
end
