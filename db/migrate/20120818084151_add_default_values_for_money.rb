class AddDefaultValuesForMoney < ActiveRecord::Migration
  def change
    change_column(:check_outs, :additional_charges_in_cents, :integer, { :default => 0, :null => false })
    change_column(:check_outs, :room_price_in_cents, :integer, { :default => 0, :null => false })
    change_column(:check_outs, :total_in_cents, :integer, { :default => 0, :null => false })
    change_column(:check_ins, :prepaid_in_cents, :integer, { :default => 0, :null => false })
    change_column(:reservations, :prepaid_in_cents, :integer, { :default => 0, :null => false })
  end
end
