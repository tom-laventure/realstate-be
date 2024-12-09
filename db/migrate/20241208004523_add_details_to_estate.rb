class AddDetailsToEstate < ActiveRecord::Migration[7.1]
  def change
    add_column :estates, :image, :string, null: true
  end
end
