class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.text :details
      t.belongs_to :model, null: false, foreign_key: true
      t.belongs_to :brand, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :distance
      t.integer :max_luggage
      t.integer :seat_count
      t.integer :case_type

      t.timestamps
    end
  end
end
