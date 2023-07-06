class AddResponseToStripeAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :stripe_accounts, :response, :jsonb, default: {}
  end
end
