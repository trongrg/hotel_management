class CreateRoomTypes < ActiveRecord::Migration
  def change
    create_table :room_types do |t|
      t.string :name
      t.text :description
      t.integer :price_cents
      t.string :currency
      t.references :hotel

      t.timestamps
    end
  end

end
