class CreateStripeAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :account_type
      t.string :dob_month
      t.string :dob_day
      t.string :dob_year
      t.string :phone
      t.string :email
      t.string :address_line
      t.string :postal_code
      t.string :city

      t.timestamps
    end
  end
end
