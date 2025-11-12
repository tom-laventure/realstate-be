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

ActiveRecord::Schema[7.1].define(version: 2025_11_11_224511) do
  create_table "agents", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone"
    t.string "license_number"
    t.string "brokerage_id"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["license_number"], name: "index_agents_on_license_number"
  end

  create_table "brokerages", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "mls_id"
    t.string "website"
    t.string "logo_url"
    t.string "contact_email"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estate_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "estate_id", null: false
    t.string "comment"
    t.string "comment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_estate_comments_on_deleted_at"
    t.index ["estate_id"], name: "index_estate_comments_on_estate_id"
    t.index ["user_id"], name: "index_estate_comments_on_user_id"
  end

  create_table "estate_ratings", force: :cascade do |t|
    t.decimal "rating", precision: 3, scale: 1, null: false
    t.integer "user_id", null: false
    t.integer "estate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_estate_ratings_on_deleted_at"
    t.index ["estate_id", "user_id"], name: "index_estate_ratings_on_estate_id_and_user_id", unique: true
    t.index ["estate_id"], name: "index_estate_ratings_on_estate_id"
    t.index ["user_id"], name: "index_estate_ratings_on_user_id"
  end

  create_table "estate_tags", force: :cascade do |t|
    t.integer "estate_id", null: false
    t.integer "tag_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estate_id", "tag_id", "group_id"], name: "index_estate_tags_on_estate_id_and_tag_id_and_group_id", unique: true
  end

  create_table "estates", force: :cascade do |t|
    t.string "header"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.datetime "deleted_at"
    t.string "image"
    t.string "price"
    t.integer "estate_ratings_count", default: 0, null: false
    t.string "mls_number"
    t.string "mls_source"
    t.string "agent_id"
    t.string "brokerage_id"
    t.boolean "is_verified", default: false
    t.index ["deleted_at"], name: "index_estates_on_deleted_at"
    t.index ["estate_ratings_count"], name: "index_estates_on_estate_ratings_count"
    t.index ["group_id"], name: "index_estates_on_group_id"
    t.index ["mls_number"], name: "index_estates_on_mls_number"
  end

  create_table "group_channels", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.integer "channel_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_group_channels_on_channel_id"
    t.index ["deleted_at"], name: "index_group_channels_on_deleted_at"
    t.index ["group_id"], name: "index_group_channels_on_group_id"
    t.index ["user_id"], name: "index_group_channels_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_groups_on_deleted_at"
  end

  create_table "listing_details", force: :cascade do |t|
    t.integer "estate_id", null: false
    t.string "list_price"
    t.string "gross_taxes"
    t.string "strata_fees"
    t.boolean "is_pre_approved_available", default: false
    t.integer "bedrooms"
    t.integer "full_bathrooms"
    t.string "property_type"
    t.string "year_built"
    t.string "age"
    t.string "title"
    t.string "style"
    t.string "heating_type"
    t.text "features"
    t.text "amenities"
    t.text "appliances"
    t.string "community"
    t.integer "days_on_market"
    t.integer "views_count"
    t.string "mls_number"
    t.string "mls_source"
    t.string "board"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estate_id"], name: "index_listing_details_on_estate_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "message"
    t.datetime "deleted_at"
    t.integer "user_id", null: false
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "channel_id"
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["deleted_at"], name: "index_messages_on_deleted_at"
    t.index ["group_id"], name: "index_messages_on_group_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "subcomments", force: :cascade do |t|
    t.integer "estate_comment_id", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_subcomments_on_deleted_at"
    t.index ["estate_comment_id"], name: "index_subcomments_on_estate_comment_id"
    t.index ["user_id"], name: "index_subcomments_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_user_groups_on_deleted_at"
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

  add_foreign_key "agents", "brokerages"
  add_foreign_key "estate_comments", "estates"
  add_foreign_key "estate_comments", "users"
  add_foreign_key "estate_ratings", "estates"
  add_foreign_key "estate_ratings", "users"
  add_foreign_key "estate_tags", "estates"
  add_foreign_key "estate_tags", "groups"
  add_foreign_key "estate_tags", "tags"
  add_foreign_key "estates", "agents"
  add_foreign_key "estates", "brokerages"
  add_foreign_key "estates", "groups"
  add_foreign_key "group_channels", "channels"
  add_foreign_key "group_channels", "groups"
  add_foreign_key "group_channels", "users"
  add_foreign_key "listing_details", "estates"
  add_foreign_key "messages", "channels"
  add_foreign_key "messages", "groups"
  add_foreign_key "messages", "users"
  add_foreign_key "subcomments", "estate_comments"
  add_foreign_key "subcomments", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
  add_foreign_key "users", "agents"
end
