class DailyCashflow < ApplicationRecord
  belongs_to :user
  belongs_to :purpose
  belongs_to :cashflow_type
  validates :amount, :occur_at, :content, presence: true
  validate :not_longer_than_year_ago?
  

  def not_longer_than_year_ago?
    if occur_at < 50.years.ago 
      errors.add(:base, "Must be less than 50 years")
    elsif occur_at > Time.now
      errors.add(:base, "Must not greater than present")
    end 
  end

  def set_time_or_time_now 
    if self.occur_at
      self.occur_at
    else 
      Time.now
    end 
  end 

end
