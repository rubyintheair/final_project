class DailyCashflow < ApplicationRecord
  belongs_to :user
  belongs_to :friend
  belongs_to :purpose
  belongs_to :cashflow_type
end
