# frozen_string_literal: true

# Team model
class Team < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Relation
  belongs_to :game
  has_many :teams_users, dependent: :destroy
  has_many :users, through: :teams_users

  def url
    Rails.application.routes.url_helpers.v1_team_url(id)
  end
end
