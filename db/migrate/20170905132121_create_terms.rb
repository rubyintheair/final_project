class CreateTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :terms do |t|
      t.integer :month

      t.timestamps
    end
  end
end
