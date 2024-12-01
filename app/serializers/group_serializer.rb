class GroupSerializer  < ActiveModel::Serializer
  attributes :name, :id, :active_listings, :user_channels
  has_many :users

  def active_listings
    object.estates.count
  end

  def current_user
    @instance_options[:current_user] || ''
  end

  def active_group
    @instance_options[:current_group] || ''
  end

  def user_channels
    if :active_group != object.id
      object.group_channels.where(user: current_user, group_id: active_group).includes(:channel).map(&:channel)
    else
      []
    end
  end
end
