class Friend < ApplicationRecord
  validates :name, presence: true
  has_many :daily_cashflows
end
