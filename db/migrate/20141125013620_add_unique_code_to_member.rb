class AddUniqueCodeToMember < ActiveRecord::Migration

  def up
    add_column :members, :code, :string
  end

  def down
    remove_column :members, :code
  end

end
