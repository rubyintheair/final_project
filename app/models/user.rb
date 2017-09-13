class User < ApplicationRecord
  validates :name, :email, presence: true, uniqueness: true
  has_secure_password
  has_many :daily_cashflows, dependent: :destroy
  
  def cashflow_by_day(date, currency)
    daily_cashflows.on_day(date).where(currency: currency).group(:cashflow_type).sum(:amount)
  end

  def cashflow_by_between(from, to, currency, cashflow_type)
    daily_cashflows.between(from, to).where(currency: currency).where(cashflow_type: cashflow_type).group_by_day(:occur_at).count
  end 

  def cashflow_by_between_general(from, to, currency, cashflow_type)
    daily_cashflows.between(from, to).where(currency: currency).where(cashflow_type: cashflow_type).group_by_day(:occur_at)
  end 

  def sum_by_between_general(from, to, currency, cashflow_type)
    cashflow_by_between_general(from, to, currency, cashflow_type).sum(:amount)
    daily_cashflows.between(from, to).where(currency: currency).where(cashflow_type: cashflow_type)
  end 

  

  def sum_by_day(date, currency)
    daily_cashflows.on_day(date).where(currency: currency).group(:cashflow_type).sum(:amount)
  end 

  def cashflow_by_day_purpose(date, currency, cashflow_type)
    daily_cashflows.on_day(date).where(currency: currency).where(cashflow_type: cashflow_type).group(:purpose_id).sum(:amount).to_a.map{|k,v| [Purpose.find(k).purpose_name, v] }.to_h
  end

  def cashflow_by_period_purpose(from, to, currency, cashflow_type)
    daily_cashflows.between(from, to).where(currency: currency).where(cashflow_type: cashflow_type).group(:purpose_id).sum(:amount).to_a.map{|k,v| [Purpose.find(k).purpose_name, v] }.to_h
  end

  def last_date
    daily_cashflows.pluck(:occur_at).max.to_date
  end 

  def last_date_cashflows
    daily_cashflows.on_day(last_date)
  end 

  def period_cashflows(from, to)
    daily_cashflows.between(from, to)
  end

  def by_day_cashflows(date) 
    daily_cashflows.on_day(date)
  end 

end
