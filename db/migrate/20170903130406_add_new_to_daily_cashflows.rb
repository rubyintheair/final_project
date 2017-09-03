class AddNewToDailyCashflows < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_cashflows, :content, :text
  end
end
