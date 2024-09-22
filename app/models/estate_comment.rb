class EstateComment < ApplicationRecord
  belongs_to :user
  belongs_to :estate
  has_many :subcomments, dependent: :destroy

  validates :comment, presence: true, length: { minimum: 2 } 
  validates :type, presence: true 
end
