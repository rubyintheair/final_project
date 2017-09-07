# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if CashflowType.count == 0
  ["Income", "Outcome"].each do |type|
    cashflow_type = CashflowType.create(trend: type)
    if cashflow_type.persisted?
      puts "Saved type with name = #{type}" 
    end 
  end
else 
  CashflowType.all.each do |type|
    puts "Quy is print #{type.trend}!!!"
  end
end 

if Purpose.count == 0 
  @all_purposes = ["Housing", "Utilities", "Food", "Clothing", "Medical/Healthcare", "Donations/Gifts", 
  "Savings and Insurance", "Entertainment and Recreation", 
  "Transportation", "Personal/Debt Payments/Misc", "Earned Income", "Portfolio Income", "Passive Income"]
  @all_purposes.each do |purpose|
    purpose = Purpose.create(purpose_name: purpose)
    if purpose.persisted?
      puts "Saved purpose with name = #{purpose}" 
    end 
  end 
else 
  Purpose.all.each do |purpose|
    puts "Quy is print #{purpose.purpose_name}!!!"
  end
end 



user = User.find(1)
20.times do 
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Faker::Date.between(2.months.ago, Date.today),
    content: Faker::Simpsons.quote,
    purpose_id: rand(1..10),
    cashflow_type_id: 3
  )
end 

20.times do 
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Faker::Date.between(2.months.ago, Date.today),
    content: Faker::Simpsons.quote,
    purpose_id: rand(11..13),
    cashflow_type_id: 2
  )
end 





