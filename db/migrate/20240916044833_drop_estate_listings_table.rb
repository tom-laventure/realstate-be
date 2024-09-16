class DropEstateListingsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :estate_listings
  end
end
