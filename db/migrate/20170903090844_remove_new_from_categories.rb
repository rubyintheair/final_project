class RemoveNewFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :type, :string
  end
end
