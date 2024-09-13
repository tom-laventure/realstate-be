class CreateEstates < ActiveRecord::Migration[7.1]
  def change
    create_table :estates do |t|
      t.string :header
      t.string :link

      t.timestamps
    end
  end
end
