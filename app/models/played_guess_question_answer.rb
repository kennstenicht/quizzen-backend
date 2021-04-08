# frozen_string_literal: true

# Played guess question model
class PlayedGuessQuestionAnswer < ApplicationRecord
  # Relation
  belongs_to :played_guess_question
  belongs_to :user, optional: true

  def url
    Rails.application.routes.url_helpers.v1_played_guess_question_answer_url(id)
  end
end
