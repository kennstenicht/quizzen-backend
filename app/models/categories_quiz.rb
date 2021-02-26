# frozen_string_literal: true

# Categories quizzes join model
class CategoriesQuiz < ApplicationRecord
  # Relation
  belongs_to :category
  belongs_to :quiz
end
