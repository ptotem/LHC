# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140416070132) do

  create_table "about_lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "about_lists_users", force: true do |t|
    t.integer "about_list_id"
    t.integer "user_id"
  end

  create_table "answers", force: true do |t|
    t.string   "name"
    t.integer  "quest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer  "user_id"
    t.integer  "institution_id"
    t.date     "year_from"
    t.date     "year_to"
    t.string   "office"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "base_matches", force: true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.boolean  "gender_fit"
    t.boolean  "age_fit"
    t.boolean  "smoking_fit"
    t.boolean  "drinking_fit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "name"
    t.string   "cover"
    t.string   "author"
    t.text     "synopsis"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "book_id", null: false
  end

  create_table "criterions", force: true do |t|
    t.integer  "user_id"
    t.boolean  "male"
    t.integer  "minage"
    t.integer  "maxage"
    t.string   "smoking"
    t.string   "drinking"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demographics", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.boolean  "male"
    t.string   "religion"
    t.date     "dob"
    t.string   "smoking"
    t.string   "drinking"
    t.text     "description"
    t.text     "goal"
    t.integer  "diffthresh"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "expectations", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "rating_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hobby_lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hobby_lists_users", force: true do |t|
    t.integer "hobby_list_id"
    t.integer "user_id"
  end

  create_table "ice_breakers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ice_breakers_users", id: false, force: true do |t|
    t.integer "ice_breaker_id", null: false
    t.integer "user_id",        null: false
  end

  create_table "institutions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests_users", id: false, force: true do |t|
    t.integer "user_id",     null: false
    t.integer "interest_id", null: false
  end

  create_table "likes", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.boolean  "status",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mind_matches", force: true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.integer  "question_id"
    t.integer  "valuediff"
    t.boolean  "mind_fit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: true do |t|
    t.string   "name"
    t.string   "poster"
    t.text     "description"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies_users", id: false, force: true do |t|
    t.integer "user_id",  null: false
    t.integer "movie_id", null: false
  end

  create_table "options", force: true do |t|
    t.string   "name"
    t.integer  "quest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personalities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personalities_users", id: false, force: true do |t|
    t.integer "user_id",        null: false
    t.integer "personality_id", null: false
  end

  create_table "professions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professions_users", id: false, force: true do |t|
    t.integer "user_id",       null: false
    t.integer "profession_id", null: false
  end

  create_table "queries", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "rating_scale_id"
    t.text     "revelation_style"
    t.text     "expectation_style"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_quizzes", force: true do |t|
    t.integer "question_id"
    t.integer "quiz_id"
  end

  create_table "quests", force: true do |t|
    t.string   "name"
    t.integer  "ice_breaker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_categories", force: true do |t|
    t.string   "name"
    t.text     "intro"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "quizzes", force: true do |t|
    t.integer  "quiz_category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "rating_scales", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "rating_scale_id"
    t.text     "revelation_style"
    t.text     "expectation_style"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipients", force: true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status"
    t.integer  "sender_id"
    t.integer  "receiver_id"
  end

  create_table "revelations", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "rating_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_contents", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "songs", force: true do |t|
    t.string   "name"
    t.string   "album"
    t.string   "band"
    t.text     "lyrics"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "song_id", null: false
  end

  create_table "total_matches", force: true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.integer  "total_fit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_documents", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.boolean  "is_admin",               default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "verification_text"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
