class AddLevelToBook < ActiveRecord::Migration
  def up
    add_column :books, :level, :integer
  end

  def down
    remove_column :books, :level
  end
end
