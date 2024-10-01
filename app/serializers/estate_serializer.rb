class EstateSerializer < ActiveModel::Serializer
  attributes :header, :link

  has_many :estate_comments
  has_many :estate_ratings
end
