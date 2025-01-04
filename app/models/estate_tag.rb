class EstateTag < ApplicationRecord
    acts_as_paranoid

    belongs_to :group
    belongs_to :estate
    belongs_to :tag
end
