class Subcomment < ApplicationRecord
    belongs_to :estate_comment
    belongs_to :user
end
