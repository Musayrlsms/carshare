class CreateStripeCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_customers do |t|
      t.string :customer_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
