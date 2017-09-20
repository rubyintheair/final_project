class Purpose < ApplicationRecord
  validates :purpose_name, presence: true, uniqueness: true
  has_many :daily_cashflows

  @all_purposes = ["Housing","Food", "Clothing", "Medical/Healthcare", 
  "Savings and Insurance", "Entertainment", "Beauty", "Travel", "Education", "Kids",
  "Transportation"]

  def icon_class 
    case purpose_name 
    when "Housing" then "home"
    when "Food" then "cutlery"
    when "Clothing" then "eye"
    when /Medical/ then "ambulance"
    when /Savings/ then "money"
    when "Entertainment" then "coffee"
    when "Beauty" then "shopping-bag"
    when "Travel" then "suitcase"
    when "Education" then "graduation-cap"
    when "Kids" then "child"
    when "Transportation" then "car"
    else "question" 
    end 
  end 

end
