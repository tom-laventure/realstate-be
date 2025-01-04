class Tag < ApplicationRecord
    acts_as_paranoid

    attribute :name

    has_many: :estate_tags, dependent: :destroy
    has_many: :estates, through: :estate_tags
    has_many: :groups, through: :estate_tags
end
