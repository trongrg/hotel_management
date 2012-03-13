class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :number
      t.integer :room_type_id

      t.timestamps
    end
  end
end
