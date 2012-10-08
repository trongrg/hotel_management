class ChangeHotelsLatLng < ActiveRecord::Migration
  def up
    change_column(:hotels, :lat, :decimal, :precision => 16, :scale => 13)
    change_column(:hotels, :lng, :decimal, :precision => 16, :scale => 13)
  end

  def down
    change_column(:hotels, :lat, :float)
    change_column(:hotels, :lng, :float)
  end
end
