class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :room_id
      t.integer :guest_id
      t.integer :user_id
      t.string :status
      t.integer :prepaid_in_cents
      t.string :currency
      t.date :check_in_date
      t.date :check_out_date

      t.timestamps
    end
  end
end
