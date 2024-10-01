class EstateCommentSerializer < ActiveModel::Serializer
  attributes :comment, :id, :comment_owner

  def comment_owner
   object.user.name
  end
end
