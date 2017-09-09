class AddCurrencyidToDailyCashflow < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_cashflows, :currency_id, :string
  end
end
