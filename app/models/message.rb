class Message < ApplicationRecord
    acts_as_paranoid

    attribute :message

    belongs_to :user
    belongs_to :group
end
