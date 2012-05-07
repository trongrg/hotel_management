class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.integer :id
      t.string :first_name
      t.string :last_name
      t.string :national_id_number
      t.string :phone_number

      t.timestamps
    end
  end
end
