class GroupSerializer
  include JSONAPI::Serializer

  attributes :name

  has_many :users
end
