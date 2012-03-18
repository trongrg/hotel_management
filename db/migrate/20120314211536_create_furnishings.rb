class CreateFurnishings < ActiveRecord::Migration
  def change
    create_table :furnishings do |t|
      t.string :name
      t.float :price
      t.string :description
      t.integer :room_type_id

      t.timestamps
    end
  end
end
