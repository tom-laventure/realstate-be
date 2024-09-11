class AddParamsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :header, :string
    add_column :users, :link, :string
  end
end
