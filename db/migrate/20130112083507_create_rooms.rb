class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :room_type

      t.timestamps
    end
    add_index :rooms, :room_type_id
  end
end
