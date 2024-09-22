class AddUserIdToSubComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :sub_comments, :user, null: false, foreign_key: true
  end
end
