# frozen_string_literal: true

# Game model
class Game < ApplicationRecord
  has_secure_password validations: false

  # Validations
  validates :title, presence: true

  # Relation
  has_and_belongs_to_many :players, class_name: 'User'
  belongs_to :quiz
  belongs_to :quiz_master, class_name: 'User'

  # Scopes
  scope :active, -> { where(active: true) }
  scope :quiz_master_is, ->(user) { where(quiz_master: user.id) }
  scope :player_is, ->(user) { where(quiz_master: user.id) }

  # Ransack
  ransack_alias :quiz_master, :quiz_master_id_or_quiz_master_nickname

  def url
    Rails.application.routes.url_helpers.v1_game_url(id)
  end
end
