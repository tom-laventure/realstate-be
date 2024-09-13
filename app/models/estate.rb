class Estate < ApplicationRecord
    has_many :estate_listings, dependent :destroy
    has_many :users, through :estate_listings
end
