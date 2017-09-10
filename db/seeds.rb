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
    puts "Quy print #{type.trend}!!!"
  end
end 

if Purpose.count == 0 
  @all_purposes = ["Housing", "Utilities", "Food", "Clothing", "Medical/Healthcare", "Donations/Gifts", 
  "Savings and Insurance", "Entertainment and Recreation", "Beauty", "Travel", "Education", "Kids",
  "Transportation", "Personal/Debt Payments/Misc"]
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

if Currency.count == 0 
  @all_currencies = ["USD", "VND", "EUR", "SGD", "CNY", "AUD", "NZD", "JPY", "KPW"]
  @all_currencies.each do |currency|
    currency = Currency.create(name: currency)
    if currency.persisted?
      puts "Saved purpose with name = #{currency}" 
    end 
  end 
else 
  Currency.all.each do |currency|
    puts "Quy print #{currency.name}!!!"
  end
end 



User.create(name: "Quy Nguyen", email: "quy.nguyenngoctp@gmail.com", password: "heo1010") if User.count == 0 
user = User.first

10.times do 
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Faker::Date.between(1.year.ago, 2.days.ago),
    content: Faker::Simpsons.quote,
    purpose_id: rand(0..Purpose.count),
    cashflow_type_id: rand(0..CashflowType.count),
    currency_id: "1"
  )
end 


10.times do 
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Date.today,
    content: Faker::Simpsons.quote,
    purpose_id: rand(0..Purpose.count),
    cashflow_type_id: rand(0..CashflowType.count),
    currency_id: "1"
  )
end 


10.times do 
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Date.today,
    content: Faker::Simpsons.quote,
    purpose_id: rand(0..Purpose.count),
    cashflow_type_id: rand(0..CashflowType.count),
    currency_id: "2"
  )
end 


10.times do 
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Faker::Date.between(1.year.ago, 2.days.ago),
    content: Faker::Simpsons.quote,
    purpose_id: rand(0..Purpose.count),
    cashflow_type_id: rand(0..CashflowType.count),
    currency_id: "2"
  )
end 








