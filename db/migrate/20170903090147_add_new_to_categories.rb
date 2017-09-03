class AddNewToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :type_new, :string
  end
end
