class Currency < ApplicationRecord
  has_many :daily_cashflows, class_name: "DailyCashflow", foreign_key: "currency_id"
  validates :name, presence: true, uniqueness: true
end
