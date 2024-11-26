class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :agent_id

  has_many :groups
  has_many :group_channels
end
