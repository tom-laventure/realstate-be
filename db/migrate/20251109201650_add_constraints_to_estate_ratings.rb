class AddConstraintsToEstateRatings < ActiveRecord::Migration[7.1]
  def change
    add_index :estate_ratings, [:estate_id, :user_id], unique: true, name: "index_estate_ratings_on_estate_id_and_user_id"
    change_column_null :estate_ratings, :rating, false, 0.0

    unless ActiveRecord::Base.connection.adapter_name.downcase.start_with?('sqlite')
      add_check_constraint :estate_ratings, "rating >= 1.0 AND rating <= 5.0", name: "rating_between_1_and_5"
    else
      # SQLite: cannot add constraint via ALTER; enforce at app/model level
    end

    add_column :estates, :estate_ratings_count, :integer, default: 0, null: false unless column_exists?(:estates, :estate_ratings_count)
    add_index :estates, :estate_ratings_count unless index_exists?(:estates, :estate_ratings_count)
  end
end
