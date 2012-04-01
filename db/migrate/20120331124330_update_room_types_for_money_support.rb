class UpdateRoomTypesForMoneySupport < ActiveRecord::Migration
  def up
    change_table(:room_types) do |t|
      t.integer :price_in_cents, :default => 0, :null => false
      t.remove :price
    end
  end

  def down
    change_table(:room_types) do |t|
      t.remove :price_in_cents
      t.float :price
    end
  end
end
