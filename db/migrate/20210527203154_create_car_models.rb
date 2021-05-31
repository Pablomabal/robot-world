class CreateCarModels < ActiveRecord::Migration[6.1]
  def change
    create_table :car_models do |t|
      t.decimal :year
      t.decimal :price, precision: 19, scale: 2
      t.decimal :cost_price, precision: 19, scale: 2
      t.string :name

      t.timestamps
    end
  end
end
