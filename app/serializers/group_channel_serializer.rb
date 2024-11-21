class GroupChannelSerializer < ActiveModel::Serializer
  attributes :group_id, user_id, :channel_id

  belongs_to: :channel, :group, :user
end
