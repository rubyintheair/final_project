class DailyCashflow < ApplicationRecord
  CASHFLOW_TYPES = ["Income", "Expense"]
  CURRENCIES = ["EUR", "USD", "VND"]
  belongs_to :user
  belongs_to :purpose # need a model because there are many of them
  enum cashflow_type: CASHFLOW_TYPES #Quy co the call DailyCashflow.cashflow_types
  enum currency: CURRENCIES
  validates :amount, :occur_at, presence: true
  validate :not_longer_than_year_ago?
  
  # before_save :set_purpose_name


  def not_longer_than_year_ago?
    if occur_at < 50.years.ago 
      errors.add(:base, "Must be less than 50 years")
    elsif occur_at > Time.now
      errors.add(:base, "Must not greater than present")
    end 
  end

  def self.on_day(date)
    where("DATE(occur_at) = ?", date.to_date)
  end 

  def self.between(from, to)
    where("occur_at >= ? AND occur_at <= ?", from, to)
  end 

  def self.as_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end 
  end 


  # def set_purpose_name
  #   if purpose
  #     self.purpose_name = purpose.name 
  #   end
  # end

end
