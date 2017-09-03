class CreateCashflowTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :cashflow_types do |t|
      t.string :trend

      t.timestamps
    end
  end
end
