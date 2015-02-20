class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.integer :member_id
      t.integer :book_id
      t.date :due_date
      t.integer :status
      t.timestamps
    end
  end
end
