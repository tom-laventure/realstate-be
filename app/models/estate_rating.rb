class EstateRating < ApplicationRecord
  belongs_to :user
  belongs_to :estate

  validates :rating, presence: true
end
