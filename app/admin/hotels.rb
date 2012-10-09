ActiveAdmin.register Hotel do
  index do
    column :id
    column :name
    column :phone_number
    column :owner
    column :created_at
    column "Address 1" do |h|
      h.address.address_1
    end
    column "Address 2" do |h|
      h.address.address_2
    end
    column "City" do |h|
      h.address.city
    end
    column "State" do |h|
      h.address.state
    end
    column "Country" do |h|
      h.address.country
    end
    default_actions
  end

  filter :name
  filter :phone_number
  filter :owner

  show do
    attributes_table do
      row :id
      row :name
      row :phone_number
      row :owner
      row "Address 1" do |h|
        h.address.address_1
      end
      row "Address 2" do |h|
        h.address.address_2
      end
      row "City" do |h|
        h.address.city
      end
      row "State" do |h|
        h.address.state
      end
      row "Country" do |h|
        h.address.country
      end
    end
  end

  form do |f|
      f.inputs "Details" do
        f.input :name
        f.input :phone_number
        f.input :owner
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
