class AddEmailToCars < ActiveRecord::Migration[7.0]
  def change

    add_column :cars, :email, :string
    add_column :cars, :phone_number, :string
    add_column :cars, :user_name, :string
    add_column :cars, :user_surname, :string
    add_column :cars, :address, :string
    add_column :cars, :state, :string
    add_column :cars, :city, :string
    add_column :cars, :model_year, :integer
    
  end
end
