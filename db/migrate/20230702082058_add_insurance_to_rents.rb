class AddInsuranceToRents < ActiveRecord::Migration[7.0]
  def change
    add_column :rents, :insurance, :float
  end
end
