class MessageSerializer < ActiveModel::Serializer
  attributes :message, :created_at, :message_owner, :message_owner_id

  def message_owner
    object.user.name
  end

  def message_owner_id
    object.user.id
  end
end
