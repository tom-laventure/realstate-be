class EstateComment < ApplicationRecord
  belongs_to :user
  belongs_to :estate
end
