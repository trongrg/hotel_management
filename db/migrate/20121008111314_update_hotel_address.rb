class UpdateHotelAddress < ActiveRecord::Migration
  def up
    remove_column(:hotels, :address1)
    remove_column(:hotels, :address2)
    remove_column(:hotels, :city)
    remove_column(:hotels, :state)
    remove_column(:hotels, :country)
    remove_column(:hotels, :zip_code)
    add_column(:hotels, :address_id, :int)
  end

  def down
    add_column(:hotels, :address1, :string)
    add_column(:hotels, :address2, :string)
    add_column(:hotels, :city, :string)
    add_column(:hotels, :state, :string)
    add_column(:hotels, :country, :string)
    add_column(:hotels, :zip_code, :string)
    remove_column(:hotels, :address_id)
  end
end
