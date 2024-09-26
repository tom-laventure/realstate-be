class Group < ApplicationRecord
    has_many :estates, dependent: :destroy
    has_many :user_groups, dependent: :destroy
    has_many :users, through: :user_groups

    validates :name, presence: true, length: { minimum: 2 } 
end