class AddStatusToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :status, :integer, default: 0, null: false
  end
end
