# frozen_string_literal: true

# Helper to access the rails url_helpers
module UrlHelpers
  extend ActiveSupport::Concern

  class_methods do
    def url_helpers
      Rails.application.routes.url_helpers
    end
  end
end
