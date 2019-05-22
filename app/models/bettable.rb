class Bettable < ApplicationRecord
  ODD_TYPE = [
    "Decimal",
    "Fractional",
    "American"
  ]

  validates :name, :description, :odds, :type, presence: true
  validates :seed, :final_ranking, numericality: { greater_than: 0 }
  validates :odds, numericality: true

  belongs_to :betch
end
