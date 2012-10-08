ActiveAdmin.register Hotel do
  index do
    column :name
    column :address1
    column :address2
    column :city
    column :state
    column :country
    column :zip_code
    column :phone_number
    column :owner
    column :created_at
    default_actions
  end

  filter :name
  filter :address1
  filter :address2
  filter :city
  filter :state
  filter :country
  filter :zip_code
  filter :phone_number
  filter :owner
end
