class RemoveAgeGroupFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :age_group
  end

  def down
    add_column :books, :age_group, :integer
  end
end
