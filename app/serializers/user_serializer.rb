class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :header, :link
end
