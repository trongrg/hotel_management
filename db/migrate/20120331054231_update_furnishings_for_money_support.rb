class UpdateFurnishingsForMoneySupport < ActiveRecord::Migration
  def up
    change_table(:furnishings) do |t|
      t.integer :price_in_cents, :default => 0, :null => false
      t.string :currency, :null => false
      t.remove :price
    end
  end

  def down
    change_table(:furnishings) do |t|
      t.remove :price_in_cents
      t.remove :currency
      t.float :price
    end
  end
end
