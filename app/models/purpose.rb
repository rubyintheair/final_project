class Purpose < ApplicationRecord
  validates :purpose_name, presence: true, uniqueness: true
  has_many :daily_cashflows
  belongs_to :cashflow_type
end
