class MessageSerializer < ActiveModel::Serializer
  attributes :message, :created_at, :message_owner, :user_id

  def message_owner
    object.user.name
  end
end
