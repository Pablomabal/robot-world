class CreateCarParts < ActiveRecord::Migration[6.1]
  def change
    create_table :car_parts do |t|
      t.references :car, null: false, foreign_key: { on_delete: :cascade }
      t.boolean :defective
      t.string :part_type

      t.timestamps
    end
  end
end
