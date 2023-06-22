class AddFullNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :mobile_number, :string
    add_column :users, :adress, :string
    add_column :users, :date_of_birth, :date
  end
end
