# frozen_string_literal: true

# Team model
class Team < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Relation
  has_and_belongs_to_many :users
  belongs_to :game

  def url
    Rails.application.routes.url_helpers.v1_team_url(id)
  end
end
