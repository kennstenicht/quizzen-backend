# frozen_string_literal: true

# Games user join model
class GamesUser < ApplicationRecord
  # Relation
  belongs_to :game
  belongs_to :user
end
