class AddFieldsToGuests < ActiveRecord::Migration
  def up
    add_column :guests, :gender, :string
    add_column :guests, :passport, :string
    remove_column :guests, :national_id_number
  end

  def down
    remove_column :guests, :gender, :passport
    add_column :guests, :national_id_number, :string
  end
end
