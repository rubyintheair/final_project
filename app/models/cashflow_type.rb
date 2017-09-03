class CashflowType < ApplicationRecord
  validates :trend, presence: true, uniqueness: true
end
