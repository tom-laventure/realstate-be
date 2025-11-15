class EstateSerializer < ActiveModel::Serializer
  attributes :address, :link, :image, :price, :id, :user_rating, :liked,
             :estate_comments, :estate_comment_count, :estate_ratings, :listing_detail


  def current_user
    @instance_options[:current_user]
  end

  #
  # 1. Avoid N+1 for user_rating
  #
  def user_rating
    return nil if current_user.nil?

    if object.association(:estate_ratings).loaded?
      object.estate_ratings.find { |r| r.user_id == current_user.id }
    else
      # Not loaded → prevent DB hit
      nil
    end
  end

  #
  # 2. Only use preloaded estate_ratings
  #
  def estate_ratings
    if object.association(:estate_ratings).loaded?
      object.estate_ratings
    else
      []
    end
  end

  #
  # 3. Only use preloaded listing_detail
  #
  def listing_detail
    if object.association(:listing_detail).loaded?
      object.listing_detail
    else
      nil
    end
  end

  #
  # 4. Comments already safe
  #
  def estate_comment_count
    object.estate_comments.size || 0
  end

  def estate_comments
    @instance_options[:comments]
  end

  def liked
    return false unless current_user && current_group

    object.estate_likes.loaded? ?
      object.estate_likes.any? { |l| l.user_id == current_user.id && l.group_id == current_group.id } :
      EstateLike.exists?(user: current_user, estate: object, group: current_group)
  end

  def current_group
    @instance_options[:group]
  end

end
