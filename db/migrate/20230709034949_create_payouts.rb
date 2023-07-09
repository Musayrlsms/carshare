class CreatePayouts < ActiveRecord::Migration[7.0]
  def change
    create_table :payouts do |t|
      t.string :message
      t.float :amount
      t.string :stripe_id
      t.integer :status, default: 0
      t.jsonb :response, default: {}
      
      t.timestamps
    end
  end
end
