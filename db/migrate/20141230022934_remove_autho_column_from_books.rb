class RemoveAuthoColumnFromBooks < ActiveRecord::Migration

  def up
    remove_column :books, :author
    add_column :books, :author_id, :integer
  end

  def down
    remove_column :books, :author_id
    add_column :books, :author, :string
  end
end
