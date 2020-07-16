# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :firstname,
            :lastname, presence: true

  validates :email, presence: true,
                    uniqueness: true

  def url
    Rails.application.routes.url_helpers.v1_user_url(id)
  end
end
