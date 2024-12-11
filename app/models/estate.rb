class Estate < ApplicationRecord
    acts_as_paranoid
    
    belongs_to :group
    has_many :estate_ratings, dependent: :destroy
    has_many :estate_comments, dependent: :destroy

    attribute :header
    attribute :image
    attribute :price
    attribute :link
end
