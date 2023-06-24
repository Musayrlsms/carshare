class AddPaymentIntentIdToRents < ActiveRecord::Migration[7.0]
  def change
    add_column :rents, :payment_intent_id, :string
  end
end
