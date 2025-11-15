class AddAddressToEstates < ActiveRecord::Migration[7.1]
  def change
    remove_column :estates, :header, :string
    add_column :estates, :address, :string
  end
end
