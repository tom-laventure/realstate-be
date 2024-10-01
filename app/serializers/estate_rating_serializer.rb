class EstateRatingSerializer < ActiveModel::Serializer
  attributes :rating, :id, :comment_owner

  def comment_owner
   object.user.name
  end


end
