class Brokerage < ApplicationRecord
  has_many :agents
  has_many :estates
end