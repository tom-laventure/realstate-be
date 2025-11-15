class CreateEstateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :estate_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :estate, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end

    add_index :estate_likes, [:user_id, :estate_id, :group_id], unique: true
  end
end
