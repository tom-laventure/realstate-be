class EstateCommentSerializer < ActiveModel::Serializer
  attributes :comment, :id, :comment_owner, :comment_type, :is_author, :subcomment_count,
              :created_at, :updated_at

  def comment_owner
     object.user.name
  end

  def is_author
    object.user === current_user
  end

  def subcomment_count
    object.subcomments.count
  end
  
  private

  def current_user
    @instance_options[:current_user]
  end
end
