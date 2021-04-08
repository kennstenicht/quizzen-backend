# frozen_string_literal: true

# Played answer model
class PlayedAnswer < ApplicationRecord
  # Relation
  belongs_to :answer
  belongs_to :played_question
  belongs_to :user

  def url
    Rails.application.routes.url_helpers.v1_played_answer_url(id)
  end
end
