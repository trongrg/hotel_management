class AddAvaiableToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :available, :boolean, :default => true, :null => false
  end
end
