class AddCollectionsAndAgentsToSchema < ActiveRecord::Migration[7.1]
    def change
    # --- BROKERAGES ---
    create_table :brokerages, id: :string do |t|
      t.string :name, null: false
      t.string :mls_id
      t.string :website
      t.string :logo_url
      t.string :contact_email
      t.string :contact_phone
      t.timestamps
    end

    # --- AGENTS ---
    create_table :agents, id: :string do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :license_number
      t.string :brokerage_id
      t.string :photo_url
      t.timestamps
    end

    add_index :agents, :email, unique: true
    add_index :agents, :license_number
    add_foreign_key :agents, :brokerages, column: :brokerage_id

    # --- USERS ---
    add_foreign_key :users, :agents, column: :agent_id

    # --- ESTATES ---
    change_table :estates do |t|
      t.string :mls_number
      t.string :mls_source
      t.string :agent_id
      t.string :brokerage_id
      t.boolean :is_verified, default: false
    end

    add_index :estates, :mls_number
    add_foreign_key :estates, :agents, column: :agent_id
    add_foreign_key :estates, :brokerages, column: :brokerage_id
  end
end