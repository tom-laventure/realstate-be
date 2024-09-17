class Estate < ApplicationRecord
    belongs_to :group
    has_many :estate_ratings, dependent: :destroy
    has_many :estate_comments, dependent: :destroy
end
