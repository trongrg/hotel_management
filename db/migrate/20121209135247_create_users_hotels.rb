class CreateUsersHotels < ActiveRecord::Migration
  def change
    create_table :hotels_users do |t|
      t.integer :user_id
      t.integer :hotel_id

      t.timestamps
    end
  end
end
