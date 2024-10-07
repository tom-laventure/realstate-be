class EstateCommentSerializer < ActiveModel::Serializer
  attributes :comment, :id, :comment_owner, :comment_type

  def comment_owner
   object.user.name
  end
end
