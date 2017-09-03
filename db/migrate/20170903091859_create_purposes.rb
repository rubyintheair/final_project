class CreatePurposes < ActiveRecord::Migration[5.1]
  def change
    create_table :purposes do |t|
      t.string :purpose_name

      t.timestamps
    end
  end
end
