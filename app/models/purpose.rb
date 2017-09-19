class Purpose < ApplicationRecord
  validates :purpose_name, presence: true, uniqueness: true
  has_many :daily_cashflows

  @all_purposes = ["Housing","Food", "Clothing", "Medical/Healthcare", 
  "Savings and Insurance", "Entertainment", "Beauty", "Travel", "Education", "Kids",
  "Transportation"]

  def icon_class 
    case purpose_name 
    when "Housing" then "home"
    when "Food" then Dir.chdir("/app/assets/images/if_meet_416384.png")
    when "Clothing" then 
    when /Medical/ then 
    when /Savings/ then 
    when "Entertainment" then 
    when "Beauty" then 
    when "Travel" then 
    when "Education" then 
    when "Kids" then 
    when "Transportation" then 
    else "question" 
    end 
  end 

end
