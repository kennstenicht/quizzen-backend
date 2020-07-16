# frozen_string_literal: true

# Answer model
class Answer < ApplicationRecord
  # Relation
  belongs_to :question

  def self.search(search)
    if search
      where('label LIKE ?', "%#{search}%")
      where('value LIKE ?', "%#{search}%")
      where('information LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def url
    Rails.application.routes.url_helpers.answer_url(id)
  end
end
