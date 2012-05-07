class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.string :status
      t.integer :room_id
      t.integer :guest_id
      t.integer :user_id
      t.integer :prepaid_in_cents
      t.string :currency

      t.timestamps
    end
  end
end
