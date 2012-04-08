class CreateHotelsUsers < ActiveRecord::Migration
  def change
    create_table :hotels_users do |t|
      t.integer :hotel_id
      t.integer :user_id
      t.string :type

      t.timestamps
    end
  end
end
