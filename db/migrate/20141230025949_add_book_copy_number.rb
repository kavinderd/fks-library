class AddBookCopyNumber < ActiveRecord::Migration
  def up
    add_column :books, :copy_number, :integer, default: 0
  end

  def down
    remove_column :books, :copy_number
  end
end
