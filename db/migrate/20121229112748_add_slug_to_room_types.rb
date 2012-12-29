class AddSlugToRoomTypes < ActiveRecord::Migration
  def change
    add_column :room_types, :slug, :string
    add_index :room_types, :slug
  end
end
