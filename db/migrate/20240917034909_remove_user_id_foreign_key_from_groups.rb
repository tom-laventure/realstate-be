class RemoveUserIdForeignKeyFromGroups < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :groups, :users
    remove_column :groups, :user_id, :integer
  end
end
