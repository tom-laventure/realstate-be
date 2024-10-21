class EstateRatingSerializer < ActiveModel::Serializer
  attributes :rating, :id, :rating_owner

  def rating_owner
   object.user.name
  end


end
