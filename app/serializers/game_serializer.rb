# frozen_string_literal: true

# Serializer for games
class GameSerializer < ApplicationSerializer
  # Attributes
  attributes :title, :active

  attribute :joined do |record, params|
    record.users.include?(params[:current_user])
  end

  attribute :your_game do |record, params|
    record.quiz_master === params[:current_user]
  end


  # Relations
  belongs_to :quiz, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_quiz_url(record.id, record.quiz.id)
    end
  }, if: proc { |record, params|
    params[:current_user] && record.quiz_master === params[:current_user]
  }

  belongs_to :quiz_master, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_user_url(record.id, record.quiz_master.id)
    end
  }

  has_many :users, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_users_url(record.id)
    end
  }, if: proc { |record, params|
    is_player = record.users.include?(params[:current_user])
    is_quiz_master = record.quiz_master === params[:current_user]

    params[:current_user] && (is_player || is_quiz_master)
  }

  has_many :game_questions, lazy_load_data: true, links: {
    self: :url,
    related: lambda do |record|
      url_helpers.v1_game_game_questions_url(record.id)
    end
  }, if: proc { |record, params|
    is_player = record.users.include?(params[:current_user])
    is_quiz_master = record.quiz_master === params[:current_user]

    params[:current_user] && (is_player || is_quiz_master)
  }
    is_quiz_master = record.quiz_master === params[:current_user]

    params[:current_user] && (is_player || is_quiz_master)
  }
end
