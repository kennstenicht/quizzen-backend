# frozen_string_literal: true

# Categories question join model
class CategoriesQuestion < ApplicationRecord
  # Relation
  belongs_to :category
  belongs_to :question
end
