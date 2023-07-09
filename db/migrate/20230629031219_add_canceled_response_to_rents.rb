class AddCanceledResponseToRents < ActiveRecord::Migration[7.0]
  def change
    add_column :rents, :canceled_response, :jsonb
  end
end
