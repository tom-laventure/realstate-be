class CreateEstateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :estate_listings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :estate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
