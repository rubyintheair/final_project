class DailyCashflow < ApplicationRecord
  belongs_to :user
  belongs_to :purpose
  belongs_to :cashflow_type
  belongs_to :currency, class_name: "Currency", foreign_key: "currency_id"
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

  def date_cashflows(date)
    DailyCashflow.where("date(occur_at) in (?)", date)
  end 

  def period_cashflows(start_date, end_date)
    DailyCashflow.where("date(occur_at) > (?) AND date(occur_at) < (?)", start_date, end_date)
  end 

  def total_cashflow(cashflows_array)
    cashflows_array.sum {|e| e.amount }
  end 

  def purpose_cashflow(cashflows_array, purpose_id)
    cashflows_array.select {|e| e.purpose_id == purpose_id }
  end 

  def type_cashflow(cashflows_array, type_id)
    cashflows_array.select {|e| e.type_id == type_id}
  end 

  

end
