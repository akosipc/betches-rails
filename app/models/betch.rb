class Betch < ApplicationRecord
  validates :name, :starts_at, :ends_at, presence: true
  validates :starts_at, :ends_at, past_date: true, on: :create
  validates :ends_at, numericality: { greater_than: :starts_at, message: "ends_at must be greater than starts_at" }

  has_many :bettables
end
