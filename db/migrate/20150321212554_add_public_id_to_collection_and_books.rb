class AddPublicIdToCollectionAndBooks < ActiveRecord::Migration
  def up
    add_column :books, :public_id, :integer
    add_column :collections, :public_id, :integer
  end

  def down
    remove_column :books, :public_id
    remove_column :collections,:public_id
  end
end
