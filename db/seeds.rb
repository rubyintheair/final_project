# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Purpose.count == 0
  @all_purposes = ["Housing", "Utilities", "Food", "Clothing", "Medical/Healthcare", "Donations/Gifts",
  "Savings and Insurance", "Entertainment and Recreation", "Beauty", "Travel", "Education", "Kids",
  "Transportation", "Personal/Debt Payments/Misc"]
  @all_purposes.each do |purpose|
    purpose = Purpose.create(purpose_name: purpose)
    if purpose.persisted?
      puts "Saved purpose with name = #{purpose.purpose_name}"
    end
  end
else
  Purpose.all.each do |purpose|
    puts "Quy is print #{purpose.purpose_name}!!!"
  end
end

User.create(name: "Quy Nguyen", email: "quy.nguyenngoctp@gmail.com", password: "heo1010") if User.count == 0
user = User.first

5.times do
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Faker::Time.between(1.year.ago, 2.days.ago),
    content: Faker::Simpsons.quote,
    purpose_id: rand(0..Purpose.count),
    cashflow_type: DailyCashflow::CASHFLOW_TYPES.sample,
    currency: DailyCashflow::CURRENCIES.sample
  )
end


5.times do
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Date.today,
    content: Faker::Simpsons.quote,
    purpose_id: rand(0..Purpose.count),
    cashflow_type: DailyCashflow::CASHFLOW_TYPES.sample,
    currency: "USD"
  )
end


5.times do
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Date.today,
    content: Faker::Simpsons.quote,
    purpose_id: rand(0..Purpose.count),
    cashflow_type: DailyCashflow::CASHFLOW_TYPES.sample,
    currency: "VND"
  )
end


5.times do
  user.daily_cashflows.create(
    amount: rand(1..500) * 1000,
    occur_at: Faker::Time.between(1.year.ago, 2.days.ago),
    content: Faker::Simpsons.quote,
    purpose_id: rand(0..Purpose.count),
    cashflow_type: DailyCashflow::CASHFLOW_TYPES.sample,
    currency: "VND"
  )
end