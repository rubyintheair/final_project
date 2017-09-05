class DailyCashflow < ApplicationRecord
  belongs_to :user
  belongs_to :friend, optional: :true
  belongs_to :purpose
  belongs_to :cashflow_type
  validates :amount, :occur_at, :content, presence: true
end
