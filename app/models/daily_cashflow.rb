class DailyCashflow < ApplicationRecord
  belongs_to :user
  belongs_to :friend, optional: :true
  belongs_to :purpose
  belongs_to :cashflow_type
  validates :amount, :occur_at, :content, presence: true
  validate :not_longer_than_year_ago?

  def not_longer_than_year_ago?
    if occur_at < 1.year.ago 
      errors.add(:base, "Must be less than 1 year")
    end 
  end
end
