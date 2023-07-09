class CreateCreditCards < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_cards do |t|
      t.string :stripe_credit_card_id
      t.string :last_four_digits
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
