class CreateEstateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :estate_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :estate, null: false, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
