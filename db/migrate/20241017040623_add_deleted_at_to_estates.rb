class AddDeletedAtToEstates < ActiveRecord::Migration[7.1]
  def change
    add_column :estates, :deleted_at, :datetime
    add_index :estates, :deleted_at

    add_column :estate_comments, :deleted_at, :datetime
    add_index :estate_comments, :deleted_at

    add_column :groups, :deleted_at, :datetime
    add_index :groups, :deleted_at

    add_column :subcomments, :deleted_at, :datetime
    add_index :subcomments, :deleted_at

    add_column :user_groups, :deleted_at, :datetime
    add_index :user_groups, :deleted_at
  end
end
