class AddFieldsToCheckIns < ActiveRecord::Migration
  def change
    add_column :check_ins, :adults, :integer
    add_column :check_ins, :children, :integer
    add_column :check_ins, :special_requirements, :string
  end
end
