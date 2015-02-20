class AddCategoryColumnToBooks < ActiveRecord::Migration
  def up
    add_column :books, :category, :integer
    add_column :books, :age_group, :integer
  end

  def down
    remove_column :books, :category
    remove_column :books, :age_group
  end
end
