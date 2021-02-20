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
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def find_parent(klasses)
    klass = klasses.detect { |pk| params[:"#{pk}_id"].present? }

    klass.camelize.constantize.find(params[:"#{klass}_id"]) if klass
  end

  def jsonapi_meta(resources)
    meta = {}
    pagination = jsonapi_pagination_meta(resources)
    _, limit = jsonapi_pagination_params

    meta[:pagination] = pagination if pagination.present?

    if resources.respond_to?(:unscope)
      total_records = resources.unscope(:limit, :offset).count
      total_pages = [1, (total_records.to_f / limit.to_f).ceil].max

      meta[:pagination][:records] = total_records
      meta[:pagination][:pages] = total_pages
    end

    meta
  end

  def user_not_authorized(exception)
    render jsonapi_errors: [
      {
        status: 403,
        title: 'Forbidden',
        detail: exception
      }
    ],
    status: :forbidden
  end

  def not_found(exception)
    render jsonapi_errors: [
      {
        status: 404,
        title: "Record not found",
        detail: exception
      }
    ],
    status: :not_found
  end
end
