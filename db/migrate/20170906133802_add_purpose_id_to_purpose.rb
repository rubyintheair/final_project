class AddPurposeIdToPurpose < ActiveRecord::Migration[5.1]
  def change
    add_column :purposes, :cashflow_type_id, :integer
  end
end
