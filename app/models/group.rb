class Group < ApplicationRecord
    acts_as_paranoid
    
    has_many :estates, dependent: :destroy
    
    has_many :user_groups, dependent: :destroy
    has_many :users, through: :user_groups
    
    has_many :messages, dependent: :destroy
    
    has_many :group_channels, dependent: :destroy
    has_many :channels, through: :group_channels

    validates :name, presence: true, length: { minimum: 2 } 
end
