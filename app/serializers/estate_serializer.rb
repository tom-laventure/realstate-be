class EstateSerializer
  include JSONAPI::Serializer
  attributes :header, :link

  has_many :estate_comments
end
