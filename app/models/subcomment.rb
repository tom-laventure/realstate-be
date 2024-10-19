class Subcomment < ApplicationRecord
    acts_as_paranoid
    
    belongs_to :estate_comment
    belongs_to :user
end
