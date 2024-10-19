class EstateRating < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :user
  belongs_to :estate

  validates :rating, presence: true
end
