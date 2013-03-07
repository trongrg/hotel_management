class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.string :status
      t.references :guest
      t.references :hotel
      t.integer :adults
      t.integer :children
      t.integer :special_request
      t.integer :prepaid_cents
      t.string :currency

      t.timestamps
    end
    add_index :check_ins, :guest_id
    add_index :check_ins, :hotel_id
  end
end
