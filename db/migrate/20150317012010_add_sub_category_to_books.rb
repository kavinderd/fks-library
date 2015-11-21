class AddSubCategoryToBooks < ActiveRecord::Migration
  def up
    add_column :books, :sub_category, :integer
  end

  def down
    remove_column :books, :sub_category
  end
end
