ActiveAdmin.register AdminUser do
  index do
    column :id
    column :username
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email
  filter :username

  show do
    attributes_table do
      row :id
      row :username
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
