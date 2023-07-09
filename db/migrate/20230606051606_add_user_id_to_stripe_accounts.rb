class AddUserIdToStripeAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :stripe_accounts, :user, null: false, foreign_key: true
  end
end
