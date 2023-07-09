class AddAccountIdToStripeAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :stripe_accounts, :account_id, :string
  end
end
