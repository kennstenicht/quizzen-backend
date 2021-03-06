# frozen_string_literal: true

# Base application Serializer
class ApplicationSerializer
  # Concerns
  include FastJsonapi::ObjectSerializer
  include UrlHelpers

  # Key transform
  set_key_transform :underscore

  # Global meta fields
  attributes :created_at, :updated_at

  # Global self link
  link :self, :url
end
