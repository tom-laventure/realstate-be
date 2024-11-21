class ChannelSerializer < ActiveModel::Serializer
  attributes :title

  has_many :messages
end
