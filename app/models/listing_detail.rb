class ListingDetail < ApplicationRecord
  belongs_to :estate

  # documented attributes (helpful for readers; real columns are defined by migrations)
  attribute :days_on_market, :integer
  attribute :views_count, :integer, default: 0
  attribute :mls_number, :string
  attribute :mls_source, :string
  attribute :board, :string
  attribute :source, :string
  attribute :price, :decimal
  attribute :beds, :integer
  attribute :baths, :integer
  attribute :sqft, :integer

  # validations
  validates :mls_number, presence: true, if: -> { estate&.is_verified? }
  validates :views_count, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :days_on_market, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # scopes / helpers
  scope :for_estates, ->(ids) { where(estate_id: ids) }

  # Helper to select all columns except the given ones (useful to avoid large/text fields)
  # def self.select_except(*excluded)
  #   excluded = excluded.map(&:to_s)
  #   cols = column_names - excluded
  #   select(cols.map { |c| "#{table_name}.\"#{c}\"" })
  # end
end