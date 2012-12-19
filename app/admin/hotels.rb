ActiveAdmin.register Hotel do
  index do
    selectable_column
    column :id
    column :name
    column :phone
    column :owners do |hotel|
      hotel.owners.map { |owner| link_to owner.full_name, admin_user_path(owner) }.join(", ").html_safe
    end
    column :created_at
    column :address
    column :location
    default_actions
  end

  filter :name
  filter :phone
  # filter :owners
  filter :created_at

  show do |hotel|
    attributes_table do
      row :id
      row :name
      row :phone
      row :owners do
        hotel.owners.map { |owner| link_to owner.full_name, admin_user_path(owner) }.join(", ").html_safe
      end
      row :address
      row :location
      row :room_types do
        hotel.room_types.map { |room_type| link_to room_type.name, hotel_room_type_path(hotel, room_type) }.join(", ").html_safe
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :phone
      f.input :owners
    end
    f.inputs :name => "Address", :for => :address do |a|
      a.input :line1
      a.input :line2
      a.input :city
      a.input :state
      a.input :zip
      a.input :country
    end
    f.inputs :name => "Location", :for => :location do |l|
      l.input :latitude
      l.input :longitude
    end
    f.buttons
  end
end
