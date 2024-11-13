class EstateSerializer < ActiveModel::Serializer
  attributes :header, :link, :id, :user_rating, :estate_comments

  def user_rating
    object.estate_ratings.find_by(user: current_user)
  end

  has_many :estate_ratings

  def current_user
    @instance_options[:current_user]
  end

  def estate_comments
    @instance_options[:comments]
  end
end
