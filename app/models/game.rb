# frozen_string_literal: true

# Game model
class Game < ApplicationRecord
  has_secure_password validations: false

  # Validations
  validates :title, presence: true

  # Relation
  has_many :played_questions
  belongs_to :guess_question, optional: true
  has_many :games_users, dependent: :destroy
  has_many :users, through: :games_users
  belongs_to :quiz
  belongs_to :quiz_master, class_name: 'User'
  has_many :teams

  # Scopes
  scope :active, -> { where(active: true) }
  scope :quiz_master_is, ->(user) { where(quiz_master: user.id) }
  scope :player_is, ->(user) { where(users: { id: user.id }) }

  # Ransack
  ransack_alias :quiz_master, :quiz_master_id_or_quiz_master_nickname
  ransack_alias :search, :title_or_quiz_master_nickname

  def url
    Rails.application.routes.url_helpers.v1_game_url(id)
  end
end
