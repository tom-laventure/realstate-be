class EstateLike < ApplicationRecord
  belongs_to :user
  belongs_to :estate
  belongs_to :group

  validates :user_id, uniqueness: { scope: [:estate_id, :group_id] }
end