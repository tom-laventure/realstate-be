class GroupSerializer  < ActiveModel::Serializer
  attributes :name, :id, :active_listings
  has_many :users

  def active_listings
    object.estates.count
  end

  def current_user
    @instance_options[:current_user] || ''
  end

  def user_channels
    object.group_channels.where(user: current_user).channels
  end
end
