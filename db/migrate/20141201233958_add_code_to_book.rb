class AddCodeToBook < ActiveRecord::Migration
  def up
    add_column :books, :code, :string
  end
  
  def down
    remove_column :books, :code
  end
end
