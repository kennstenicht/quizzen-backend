# frozen_string_literal: true

# Question model
class Question < ApplicationRecord
  # Relation
  has_many :answers

  def self.search(search)
    if search
      where('label LIKE ?', "%#{search}%")
      where('source LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def url
    Rails.application.routes.url_helpers.question_url(id)
  end
end
