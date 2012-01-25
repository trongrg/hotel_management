class CreateRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_types do |t|
      t.string :name
      t.float :price
      t.string :currency
      t.text :description
      t.string :image
      t.integer :hotel_id

      t.timestamps
    end
  end
end
