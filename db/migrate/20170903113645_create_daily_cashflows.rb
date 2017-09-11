class CreateDailyCashflows < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_cashflows do |t|
      t.integer :amount
      t.datetime :occur_at
      t.references :user, foreign_key: true
      t.references :purpose, foreign_key: true
      t.integer :cashflow_type
      t.integer :currency

      t.timestamps
    end
  end
end
