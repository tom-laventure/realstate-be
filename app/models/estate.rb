class Estate < ApplicationRecord
    acts_as_paranoid

    belongs_to :group
    belongs_to :agent, optional: true
    belongs_to :brokerage, optional: true
    has_many :estate_ratings, dependent: :destroy
    has_many :estate_comments, dependent: :destroy
    has_many :estate_tags, dependent: :destroy
    has_many :tags, through: :estate_tags

    has_many :estate_likes, dependent: :destroy
    has_many :liked_by_users, through: :estate_likes, source: :user
    
    has_one :listing_detail, dependent: :destroy

    accepts_nested_attributes_for :listing_detail, update_only: true

    attribute :address
    attribute :image
    attribute :price
    attribute :link
end
