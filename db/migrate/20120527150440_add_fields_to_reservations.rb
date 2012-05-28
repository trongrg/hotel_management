class AddFieldsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :adults, :integer
    add_column :reservations, :children, :integer
    add_column :reservations, :special_requirements, :string
  end
end
