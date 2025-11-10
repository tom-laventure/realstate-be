class EstateRating < ApplicationRecord
  belongs_to :estate, counter_cache: :estate_ratings_count
  belongs_to :user

  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :user_id, uniqueness: { scope: :estate_id, message: "has already rated this estate" }
end
