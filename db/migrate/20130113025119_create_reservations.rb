class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :hotel
      t.references :guest
      t.string :status
      t.string :prepaid_cents
      t.string :currency
      t.date :check_in_date
      t.date :check_out_date
      t.integer :adults
      t.integer :children
      t.text :special_request

      t.timestamps
    end
    add_index :reservations, :hotel_id
    add_index :reservations, :guest_id
  end
end
