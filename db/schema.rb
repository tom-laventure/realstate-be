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

ActiveRecord::Schema[7.1].define(version: 2024_10_08_043303) do
  create_table "estate_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "estate_id", null: false
    t.string "comment"
    t.string "comment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estate_id"], name: "index_estate_comments_on_estate_id"
    t.index ["user_id"], name: "index_estate_comments_on_user_id"
  end

  create_table "estate_ratings", force: :cascade do |t|
    t.decimal "rating", precision: 3, scale: 1
    t.integer "user_id", null: false
    t.integer "estate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estate_id"], name: "index_estate_ratings_on_estate_id"
    t.index ["user_id"], name: "index_estate_ratings_on_user_id"
  end

  create_table "estates", force: :cascade do |t|
    t.string "header"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.index ["group_id"], name: "index_estates_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subcomments", force: :cascade do |t|
    t.integer "estate_comment_id", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["estate_comment_id"], name: "index_subcomments_on_estate_comment_id"
    t.index ["user_id"], name: "index_subcomments_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "jti", null: false
    t.string "agent_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "estate_comments", "estates"
  add_foreign_key "estate_comments", "users"
  add_foreign_key "estate_ratings", "estates"
  add_foreign_key "estate_ratings", "users"
  add_foreign_key "estates", "groups"
  add_foreign_key "subcomments", "estate_comments"
  add_foreign_key "subcomments", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
