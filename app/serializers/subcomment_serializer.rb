class SubcommentSerializer < ActiveModel::Serializer
  attributes :comment, :comment_owner, :is_author, :id

  def comment_owner
    object.user.name
  end

  def is_author
    object.user === current_user
  end

  private

  def current_user
    @instance_options[:current_user]
  end
end
