class CreateSubcomments < ActiveRecord::Migration[7.1]
  def change
    create_table :subcomments do |t|
      t.references :estate_comments, null: false, foreign_key: true
      t.string :comment
      t.timestamps
    end
  end
end
