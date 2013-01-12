ActiveAdmin.register RoomType do
  index do
    selectable_column
    column :id
    column :name
    column :description
    column :hotel
    column :price do |room_type|
      room_type.price.format
    end
    column :created_at
    default_actions
  end

  filter :name
  filter :description
  filter :hotel
  filter :price_cents
  filter :currency

  show do |room_type|
    attributes_table do
      row :id
      row :name
      row :description
      row :hotel
      row :rooms do
        room_type.rooms.map { |room| link_to room.name, [:admin, room] }.join(", ").html_safe
      end
      row :price do
        room_type.price.format
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :hotel
    end
    f.inputs :name => "Price", :for => :price do |p|
      p.input :dollars
      p.input :currency
    end
    f.buttons
  end
end
