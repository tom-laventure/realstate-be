class EstateRatingSerializer < ActiveModel::Serializer
  attributes :rating

  belongs_to :user
end
