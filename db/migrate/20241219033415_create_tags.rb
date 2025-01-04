class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table "tags", force: :cascade do |t|
      t.string "name", null: false
      t.timestamps
    end
  
    create_table "estate_tags", force: :cascade do |t|
      t.integer "estate_id", null: false
      t.integer "tag_id", null: false
      t.integer "group_id", null: false
      t.timestamps
    end
  
    add_foreign_key "estate_tags", "estates"
    add_foreign_key "estate_tags", "tags"
    add_foreign_key "estate_tags", "groups"
    add_index "estate_tags", ["estate_id", "tag_id", "group_id"], unique: true
  end
end
