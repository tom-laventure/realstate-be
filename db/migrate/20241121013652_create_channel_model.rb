class CreateChannelModel < ActiveRecord::Migration[7.1]
  def change
    create_table :channels do |t|
      t.string :name, 
      t.timestamps
    end

    create_table :group_channels do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
    
    change_column_null :messages, :group_id, true
    add_reference :messages, :channel, null: true, foreign_key: true
    
  end
end