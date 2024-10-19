class EstateComment < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :user
  belongs_to :estate
  has_many :subcomments, dependent: :destroy

  validates :comment, presence: true, length: { minimum: 2 } 
  validates :comment_type, presence: true 

  attribute :comment
  attribute :id
end
