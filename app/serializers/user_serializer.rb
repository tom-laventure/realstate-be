class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :agent_id

  has_many :groups
end
