class ChangeCaseTypeToStringInCars < ActiveRecord::Migration[7.0]
  def change
    change_column :cars, :case_type, :string
  end
end
