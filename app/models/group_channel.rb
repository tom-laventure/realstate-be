class GroupChannel < ApplicationRecord
    acts_as_paranoid
  
    belongs_to :group
    belongs_to :user
    belongs_to :channel
  end