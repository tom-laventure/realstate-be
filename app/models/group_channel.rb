class GroupChannel < ApplicationRecord
    acts_as_paranoid

    belongs_to :group, :user, :channel
end
