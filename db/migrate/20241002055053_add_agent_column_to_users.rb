class AddAgentColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :agent_id, :string
  end
end
