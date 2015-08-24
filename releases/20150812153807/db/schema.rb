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

ActiveRecord::Schema.define(version: 20150722065332) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "username",               limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "admins_roles", id: false, force: :cascade do |t|
    t.integer "admin_id", limit: 4, null: false
    t.integer "role_id",  limit: 4, null: false
  end

  create_table "choices", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.string   "content",     limit: 255
    t.boolean  "is_correct",  limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "choices", ["question_id"], name: "index_choices_on_question_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "level",      limit: 255
    t.string   "duration",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind",       limit: 255, default: "normal"
    t.string   "standard",   limit: 255
    t.boolean  "published",  limit: 1,   default: false
  end

  create_table "homeworks", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.text     "answer",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "feedback",    limit: 65535
    t.integer  "admin_id",    limit: 4
    t.datetime "expires"
  end

  add_index "homeworks", ["question_id"], name: "index_homeworks_on_question_id", using: :btree
  add_index "homeworks", ["user_id"], name: "index_homeworks_on_user_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string   "action",      limit: 255
    t.string   "subject",     limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions_roles", id: false, force: :cascade do |t|
    t.integer "permission_id", limit: 4, null: false
    t.integer "role_id",       limit: 4, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.string   "phone",               limit: 255
    t.string   "wechat",              limit: 255
    t.string   "qq",                  limit: 255
    t.integer  "user_id",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",             limit: 255
    t.string   "zip_code",            limit: 255
    t.string   "level",               limit: 255, default: "None"
    t.string   "real_name",           limit: 255
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "unit_id",    limit: 4
    t.string   "kind",       limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["unit_id"], name: "index_questions_on_unit_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_evaluations", force: :cascade do |t|
    t.integer  "score",       limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "unit_id",     limit: 4
    t.datetime "start_time"
    t.datetime "finish_time"
    t.time     "duration"
    t.boolean  "submitted",   limit: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "expectation", limit: 255
  end

  add_index "unit_evaluations", ["unit_id"], name: "index_unit_evaluations_on_unit_id", using: :btree
  add_index "unit_evaluations", ["user_id"], name: "index_unit_evaluations_on_user_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.integer  "course_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pdf_file_name",    limit: 255
    t.string   "pdf_content_type", limit: 255
    t.integer  "pdf_file_size",    limit: 4
    t.datetime "pdf_updated_at"
  end

  add_index "units", ["course_id"], name: "index_units_on_course_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",       null: false
    t.string   "username",               limit: 255, default: "",       null: false
    t.string   "encrypted_password",     limit: 255, default: "",       null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_status",         limit: 255, default: "unpaid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "choices", "questions", name: "index_choices_on_question_id"
  add_foreign_key "homeworks", "questions", name: "index_homeworks_on_question_id"
  add_foreign_key "homeworks", "users", name: "index_homeworks_on_user_id"
  add_foreign_key "questions", "units", name: "index_questions_on_unit_id"
  add_foreign_key "unit_evaluations", "units"
  add_foreign_key "unit_evaluations", "users"
  add_foreign_key "units", "courses", name: "index_units_on_course_id"
end
