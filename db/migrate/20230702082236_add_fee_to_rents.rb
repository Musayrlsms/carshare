class AddFeeToRents < ActiveRecord::Migration[7.0]
  def change
    add_column :rents, :fee, :float
  end
end
