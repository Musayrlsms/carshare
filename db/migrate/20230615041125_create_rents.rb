class CreateRents < ActiveRecord::Migration[7.0]
  def change
    create_table :rents do |t|
      t.references :car, null: false, foreign_key: true
      t.references :renter, null: false, foreign_key: {to_table: :users}
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.datetime :start_date
      t.datetime :finish_date

      t.timestamps
    end
  end
end
