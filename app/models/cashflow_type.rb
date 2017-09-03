class CashflowType < ApplicationRecord
  validates :trend, presence: true, uniqueness: true
  has_many :daily_cashflows
end
