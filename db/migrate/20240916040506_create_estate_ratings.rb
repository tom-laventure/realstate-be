class CreateEstateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :estate_ratings do |t|
      t.decimal :rating, precision: 3, scale: 1
      t.references :user, null: false, foreign_key: true
      t.references :estate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
