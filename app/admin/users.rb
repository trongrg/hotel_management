ActiveAdmin.register User do
  index do
    column :username
    column :email
    column :first_name
    column :last_name
    column :phone_number
    column :dob
    default_actions
  end

  filter :username
  filter :email
  filter :first_name
  filter :last_name
  filter :phone_number
  filter :dob

  form do |f|
      f.inputs "Personal Details" do
        f.input :username
        f.input :email
        f.input :first_name
        f.input :last_name
        f.input :phone_number
        f.input :dob
      end
      f.inputs "Address" do
        f.input :address1
        f.input :address2
        f.input :city
        f.input :state
        f.input :country
        f.input :zip_code
      end
      f.buttons
    end
end
