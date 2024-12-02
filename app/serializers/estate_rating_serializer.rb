class EstateRatingSerializer < ActiveModel::Serializer
  attributes :rating, :id, :rating_owner, :rating_owner_id

  def rating_owner
   object.user.name
  end

  def rating_owner_id
    object.user.id
  end


end
