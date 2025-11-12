class Estate < ApplicationRecord
    acts_as_paranoid

    belongs_to :group
    belongs_to :agent, optional: true
    belongs_to :brokerage, optional: true
    has_many :estate_ratings, dependent: :destroy
    has_many :estate_comments, dependent: :destroy
    has_many :estate_tags, dependent: :destroy
    has_many :tags, through: :estate_tags
    
    has_one :listing_detail, dependent: :destroy

    accepts_nested_attributes_for :listing_detail, update_only: true

    attribute :header
    attribute :image
    attribute :price
    attribute :link
end
