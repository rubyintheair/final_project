class CashflowType < ApplicationRecord
  validates :trend, presence: true, uniqueness: true
  has_many :daily_cashflows
  has_many :purposes, class_name: "Purpose", foreign_key: "cashflow_type_id"
end
