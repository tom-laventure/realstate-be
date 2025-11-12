class Agent < ApplicationRecord
  belongs_to :brokerage, optional: true
  has_many :estates
  has_many :users
end