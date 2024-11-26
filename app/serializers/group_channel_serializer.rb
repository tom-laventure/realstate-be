class GroupChannelSerializer < ActiveModel::Serializer
  belongs_to :channel
  belongs_to :group
  belongs_to :user
end