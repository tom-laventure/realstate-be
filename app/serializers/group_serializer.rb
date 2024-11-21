class GroupSerializer  < ActiveModel::Serializer
  attributes :name, :id, :active_listings

  def active_listings
    object.estates.count
  end

  has_many :users, :channels
end
