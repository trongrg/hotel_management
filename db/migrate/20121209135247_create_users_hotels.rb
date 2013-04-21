class CreateUsersHotels < ActiveRecord::Migration
  def change
    create_table :hotels_users, :id => false do |t|
      t.references :user, :hotel
    end

    add_index :hotels_users, [:user_id, :hotel_id]
  end
end
