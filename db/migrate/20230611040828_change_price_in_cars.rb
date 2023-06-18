class ChangePriceInCars < ActiveRecord::Migration[7.0]
  def change
    change_column :cars, :price, :float, default: 0.0, null: false
  end
end
