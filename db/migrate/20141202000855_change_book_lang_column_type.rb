class ChangeBookLangColumnType < ActiveRecord::Migration

  def up
    remove_column :books, :language
    add_column :books, :language, :integer
  end

  def down
    remove_column :books, :language
    add_column :books, :language, :string
  end

end
