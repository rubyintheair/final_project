class User < ApplicationRecord
  validates :name, :email, presence: true, uniqueness: true
  has_secure_password
  has_many :daily_cashflows, dependent: :destroy

  

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
    cashflows_array.select {|e| e.cashflow_type_id == type_id}
  end 

end
