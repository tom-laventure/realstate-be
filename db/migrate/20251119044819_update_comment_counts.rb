class UpdateCommentCounts < ActiveRecord::Migration[7.1]
  def change
    add_column :estate_comments, :subcomment_count, :integer, default: 0, null: false
    remove_column :estates, :estate_ratings_count, :integer
    
    # Backfill existing counts
    reversible do |dir|
      dir.up do
        EstateComment.find_each do |comment|
          count = Subcomment.where(estate_comment_id: comment.id).count
          comment.update_column(:subcomment_count, count)
        end
      end
    end
  end
end
