class AddParamsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
  end
end
