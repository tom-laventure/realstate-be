class CreateListingDetails < ActiveRecord::Migration[7.1]
  def change
 create_table :listing_details do |t|
      t.references :estate, null: false, foreign_key: true, index: true

      # Price details
      t.string  :list_price
      t.string  :gross_taxes
      t.string  :strata_fees
      t.boolean :is_pre_approved_available, default: false

      # Home facts
      t.integer :bedrooms
      t.integer :full_bathrooms
      t.string  :property_type
      t.string  :year_built
      t.string  :age
      t.string  :title
      t.string  :style
      t.string  :heating_type

      # Descriptive features
      t.text    :features
      t.text    :amenities
      t.text    :appliances
      t.string  :community

      # Listing info
      t.integer :days_on_market
      t.integer :views_count
      t.string  :mls_number
      t.string  :mls_source
      t.string  :board

      t.timestamps
    end
  end
end
