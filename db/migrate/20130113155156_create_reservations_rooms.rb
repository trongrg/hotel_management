class CreateReservationsRooms < ActiveRecord::Migration
  def change
    create_table :reservations_rooms do |t|
      t.references :reservation
      t.references :room
    end
    add_index :reservations_rooms, :reservation_id
    add_index :reservations_rooms, :room_id
  end
end
