ActiveAdmin.register User do
  index do
    column :username
    column :email
    column :first_name
    column :last_name
    column :phone_number
    column :dob
    column "Address 1" do |u|
      u.address.address_1
    end
    column "Address 2" do |u|
      u.address.address_2
    end
    column "City" do |u|
      u.address.city
    end
    column "State" do |u|
      u.address.state
    end
    column "Country" do |u|
      u.address.country
    end
    default_actions
  end

  show do
    attributes_table do
      row :username
      row :email
      row :first_name
      row :last_name
      row :phone_number
      row :dob
      row 'Address 1' do |u|
        u.address.address_1
      end
      row 'Address 2' do |u|
        u.address.address_2
      end
      row 'City' do |u|
        u.address.city
      end
      row 'State' do |u|
        u.address.state
      end
      row 'Country' do |u|
        u.address.country
      end
    end
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
        f.input :dob, :as => :date_select, :start_year => 100.year.ago.year, :end_year => Time.now.year, :include_blank => false
      end
      f.inputs :name => "Address", :for => :address do |a|
        a.input :address_1
        a.input :address_2
        a.input :city
        a.input :state
        a.input :country
      end
      f.buttons
  end
end
