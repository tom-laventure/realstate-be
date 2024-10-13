class SubcommentSerializer < ActiveModel::Serializer
  attributes :comment, :comment_owner

  belongs_to :user

  def comment_owner
    object.user.name
  end
end
