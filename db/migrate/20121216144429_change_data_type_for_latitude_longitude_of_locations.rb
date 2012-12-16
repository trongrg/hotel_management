class ChangeDataTypeForLatitudeLongitudeOfLocations < ActiveRecord::Migration
  def up
    change_column :locations, :latitude, :decimal, :precision => 20, :scale => 16
    change_column :locations, :longitude, :decimal, :precision => 20, :scale => 16
  end

  def down
    change_column :locations, :latitude, :float
    change_column :locations, :longitude, :float
  end
end
