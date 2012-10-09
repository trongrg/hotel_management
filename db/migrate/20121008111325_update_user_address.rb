class UpdateUserAddress < ActiveRecord::Migration
  def up
    remove_column(:users, :address1)
    remove_column(:users, :address2)
    remove_column(:users, :city)
    remove_column(:users, :state)
    remove_column(:users, :country)
    remove_column(:users, :zip_code)
    add_column(:users, :address_id, :int)
  end

  def down
    add_column(:users, :address1, :string)
    add_column(:users, :address2, :string)
    add_column(:users, :city, :string)
    add_column(:users, :state, :string)
    add_column(:users, :country, :string)
    add_column(:users, :zip_code, :string)
    remove_column(:users, :address_id)
  end
end

