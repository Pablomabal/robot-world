class CreateComputers < ActiveRecord::Migration[6.1]
  def change
    create_table :computers do |t|
      t.references :car, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end