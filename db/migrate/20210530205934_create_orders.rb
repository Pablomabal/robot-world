class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :car, null: false, foreign_key: true
      t.references :car_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end