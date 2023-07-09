class CreateRuleCars < ActiveRecord::Migration[7.0]
  def change
    create_table :rule_cars do |t|
      t.references :rule, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
