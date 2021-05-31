class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.references :car_model, null: false, foreign_key: true
      t.string :state
      t.string :location
      t.integer :order_id

      t.timestamps
    end
  end
end
