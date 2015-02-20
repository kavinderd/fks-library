class AddColumnsToMember < ActiveRecord::Migration
  def change
    add_column :members, :student_number, :integer
    add_column :members, :registration_status, :integer
    add_column :members, :dob, :date
    add_column :members, :gender, :string
    add_column :members, :phone_number, :string
    add_column :members, :address, :string
  end
end
