# frozen_string_literal: true

# Teams user join model
class TeamsUser < ApplicationRecord
  # Relation
  belongs_to :game
  belongs_to :user
end
