class CreateCheckOuts < ActiveRecord::Migration
  def change
    create_table :check_outs do |t|
      t.integer :user_id
      t.integer :room_id
      t.integer :check_in_id
      t.integer :guest_id
      t.integer :room_price_in_cents
      t.integer :nights
      t.integer :additional_charges_in_cents
      t.integer :total_in_cents
      t.string :currency
      t.string :settlement_type

      t.timestamps
    end
  end
end
