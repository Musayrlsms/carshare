class AddCarTypeToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :car_type, :string
  end
end
