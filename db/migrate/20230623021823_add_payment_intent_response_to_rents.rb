class AddPaymentIntentResponseToRents < ActiveRecord::Migration[7.0]
  def change
    add_column :rents, :payment_intent_response, :jsonb, default: '{}'
    add_column :rents, :payment_status, :integer, default: 0
  end
end
