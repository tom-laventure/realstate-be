class AddGroupIdToEstates < ActiveRecord::Migration[7.1]
  def change
    add_reference :estates, :group, foreign_key: true
  end
end
