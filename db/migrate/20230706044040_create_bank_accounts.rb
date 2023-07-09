class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.string :bank_account_id
      t.references :user, null: false, foreign_key: true
      t.string :iban
      t.jsonb :response, default: {}

      t.timestamps
    end
  end
end
