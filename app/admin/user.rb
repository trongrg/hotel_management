ActiveAdmin.register User do
  index do
    column :email
    column :first_name
    column :last_name
    column :gender
    column :date_of_birth
    column :phone
    column :current_sign_in_at
    column :last_sign_in_at
    default_actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :gender
  filter :date_of_birth
  filter :phone


  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :gender, :as => :select, :collection => ["Male", "Female"]
      f.input :date_of_birth, :start_year => Time.now.year, :end_year => 100.years.ago.year
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
