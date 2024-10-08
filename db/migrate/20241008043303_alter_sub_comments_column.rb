class AlterSubCommentsColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :subcomments, :estate_comments_id, :estate_comment_id
  end
end
