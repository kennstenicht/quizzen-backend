# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_05_133558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "information"
    t.string "label"
    t.string "value"
    t.uuid "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.uuid "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_categories_on_owner_id"
  end

  create_table "categories_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "position"
    t.uuid "category_id"
    t.uuid "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_categories_questions_on_category_id"
    t.index ["position"], name: "index_categories_questions_on_position"
    t.index ["question_id"], name: "index_categories_questions_on_question_id"
  end

  create_table "categories_quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "position"
    t.uuid "category_id"
    t.uuid "quiz_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_categories_quizzes_on_category_id"
    t.index ["position"], name: "index_categories_quizzes_on_position"
    t.index ["quiz_id"], name: "index_categories_quizzes_on_quiz_id"
  end

  create_table "games", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "active"
    t.string "password_digest"
    t.string "title"
    t.uuid "quiz_id"
    t.uuid "quiz_master_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_id"], name: "index_games_on_quiz_id"
    t.index ["quiz_master_id"], name: "index_games_on_quiz_master_id"
  end

  create_table "games_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_id"
    t.uuid "user_id"
    t.index ["game_id"], name: "index_games_users_on_game_id"
    t.index ["user_id"], name: "index_games_users_on_user_id"
  end

  create_table "guess_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "answer"
    t.string "unit"
    t.datetime "date"
    t.string "label"
    t.string "source"
    t.uuid "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_guess_questions_on_owner_id"
  end

  create_table "played_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "position"
    t.uuid "answer_id"
    t.uuid "played_question_id"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_played_answers_on_answer_id"
    t.index ["played_question_id"], name: "index_played_answers_on_played_question_id"
    t.index ["position"], name: "index_played_answers_on_position"
    t.index ["user_id"], name: "index_played_answers_on_user_id"
  end

  create_table "played_guess_question_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "answer"
    t.uuid "played_guess_question_id"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["played_guess_question_id"], name: "index_played_guess_question_answers_on_played_guess_question_id"
    t.index ["user_id"], name: "index_played_guess_question_answers_on_user_id"
  end

  create_table "played_guess_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_id"
    t.uuid "played_question_id"
    t.uuid "guess_question_id"
    t.uuid "winner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_played_guess_questions_on_game_id"
    t.index ["guess_question_id"], name: "index_played_guess_questions_on_guess_question_id"
    t.index ["played_question_id"], name: "index_played_guess_questions_on_played_question_id"
    t.index ["winner_id"], name: "index_played_guess_questions_on_winner_id"
  end

  create_table "played_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "position"
    t.uuid "game_id"
    t.uuid "question_id"
    t.uuid "winner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_played_questions_on_game_id"
    t.index ["position"], name: "index_played_questions_on_position"
    t.index ["question_id"], name: "index_played_questions_on_question_id"
    t.index ["winner_id"], name: "index_played_questions_on_winner_id"
  end

  create_table "questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "date"
    t.string "label"
    t.string "source"
    t.uuid "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_questions_on_owner_id"
  end

  create_table "quizzes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.uuid "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_quizzes_on_owner_id"
  end

  create_table "self_assessments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "assessment"
    t.uuid "played_question_id"
    t.uuid "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["played_question_id"], name: "index_self_assessments_on_played_question_id"
    t.index ["user_id"], name: "index_self_assessments_on_user_id"
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "game_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_teams_on_game_id"
  end

  create_table "teams_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "team_id"
    t.uuid "user_id"
    t.index ["team_id"], name: "index_teams_users_on_team_id"
    t.index ["user_id"], name: "index_teams_users_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.string "nickname"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "categories", "users", column: "owner_id"
  add_foreign_key "categories_questions", "categories"
  add_foreign_key "categories_questions", "questions"
  add_foreign_key "categories_quizzes", "categories"
  add_foreign_key "categories_quizzes", "quizzes"
  add_foreign_key "games", "quizzes"
  add_foreign_key "games", "users", column: "quiz_master_id"
  add_foreign_key "games_users", "games"
  add_foreign_key "games_users", "users"
  add_foreign_key "guess_questions", "users", column: "owner_id"
  add_foreign_key "played_answers", "answers"
  add_foreign_key "played_answers", "played_questions"
  add_foreign_key "played_answers", "users"
  add_foreign_key "played_guess_question_answers", "played_guess_questions"
  add_foreign_key "played_guess_question_answers", "users"
  add_foreign_key "played_guess_questions", "games"
  add_foreign_key "played_guess_questions", "guess_questions"
  add_foreign_key "played_guess_questions", "played_questions"
  add_foreign_key "played_guess_questions", "users", column: "winner_id"
  add_foreign_key "played_questions", "games"
  add_foreign_key "played_questions", "questions"
  add_foreign_key "played_questions", "users", column: "winner_id"
  add_foreign_key "questions", "users", column: "owner_id"
  add_foreign_key "quizzes", "users", column: "owner_id"
  add_foreign_key "self_assessments", "played_questions"
  add_foreign_key "self_assessments", "users"
  add_foreign_key "teams", "games"
  add_foreign_key "teams_users", "teams"
  add_foreign_key "teams_users", "users"
end
