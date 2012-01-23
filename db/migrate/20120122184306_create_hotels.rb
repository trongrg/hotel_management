class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.string :phone_number
      t.float :lat
      t.float :lng
      t.integer :owner_id

      t.timestamps
    end
  end
end
