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

ActiveRecord::Schema.define(version: 20170524223639) do

  create_table "choices", force: :cascade do |t|
    t.integer  "multi_q_id", null: false
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_choices_on_name"
  end

  create_table "multi_answers", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "choice_id"
    t.integer  "multi_q_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "choice_id", "multi_q_id"], name: "index_multi_answers_on_user_id_and_choice_id_and_multi_q_id", unique: true
  end

  create_table "multi_qs", force: :cascade do |t|
    t.string   "question",                   null: false
    t.integer  "survey_id",                  null: false
    t.boolean  "required",   default: false
    t.boolean  "multiple",   default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["question", "survey_id"], name: "index_multi_qs_on_question_and_survey_id", unique: true
  end

  create_table "range_answers", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.integer  "value",            null: false
    t.integer  "range_q_and_c_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id", "range_q_and_c_id"], name: "index_range_answers_on_user_id_and_range_q_and_c_id", unique: true
  end

  create_table "range_q_and_cs", force: :cascade do |t|
    t.string   "question",   null: false
    t.integer  "min",        null: false
    t.integer  "max",        null: false
    t.integer  "survey_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question", "survey_id"], name: "index_range_q_and_cs_on_question_and_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
