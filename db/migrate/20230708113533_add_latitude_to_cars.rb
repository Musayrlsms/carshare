class AddLatitudeToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :latitude, :string
  end
end
