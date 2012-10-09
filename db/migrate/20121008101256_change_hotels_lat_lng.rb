class ChangeHotelsLatLng < ActiveRecord::Migration
  def up
    change_column(:hotels, :lat, :decimal, :precision => 18, :scale => 14)
    change_column(:hotels, :lng, :decimal, :precision => 18, :scale => 14)
  end

  def down
    change_column(:hotels, :lat, :float)
    change_column(:hotels, :lng, :float)
  end
end
