# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_31_131528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", id: :serial, force: :cascade do |t|
    t.string "label"
    t.string "value"
    t.string "information"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_categories_on_owner_id"
  end

  create_table "categories_questions", id: false, force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "question_id"
    t.index ["category_id"], name: "index_categories_questions_on_category_id"
    t.index ["question_id"], name: "index_categories_questions_on_question_id"
  end

  create_table "categories_quizzes", id: false, force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "quiz_id"
    t.index ["category_id"], name: "index_categories_quizzes_on_category_id"
    t.index ["quiz_id"], name: "index_categories_quizzes_on_quiz_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.string "label"
    t.string "source"
    t.datetime "date"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_questions_on_owner_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_quizzes_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.string "nickname"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "categories", "users", column: "owner_id"
  add_foreign_key "categories_questions", "categories"
  add_foreign_key "categories_questions", "questions"
  add_foreign_key "categories_quizzes", "categories"
  add_foreign_key "categories_quizzes", "quizzes"
  add_foreign_key "questions", "users", column: "owner_id"
  add_foreign_key "quizzes", "users", column: "owner_id"
end
