class Subcomment < ApplicationRecord
    acts_as_paranoid

    belongs_to :estate_comment, counter_cache: true
    belongs_to :user

    validates :comment, presence: true
  
end
