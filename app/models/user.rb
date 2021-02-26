# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :firstname,
            :lastname, presence: true

  validates :email, presence: true,
                    uniqueness: true

  validates :nickname, presence: true,
                       uniqueness: true,
                       format: {
                         with: /\A[a-zA-Z]+\z/,
                         message: 'only allows letters'
                       }

  # Relation
  has_many :games_users, dependent: :destroy
  has_many :games, through: :games_users
  has_many :teams_users, dependent: :destroy
  has_many :teams, through: :teams_users

  def url
    Rails.application.routes.url_helpers.v1_user_url(id)
  end
end
