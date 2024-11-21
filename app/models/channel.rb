class Channel < ApplicationRecord
    acts_as_paranoid

    has_many :group_channels, dependent: :destroy
    has_many: :groups, through: :group_channels
    has_many: :users, though: :group_channels
    has_many: :messages, through: :group_channels
end
