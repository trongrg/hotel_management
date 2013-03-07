class CreateCheckInsRooms < ActiveRecord::Migration
  def change
    create_table :check_ins_rooms, :id => false do |t|
      t.references :check_in
      t.references :room
    end
    add_index :check_ins_rooms, [:check_in_id, :room_id]
    add_index :check_ins_rooms, [:room_id, :check_in_id]
  end
end
