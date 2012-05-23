p "Create roles:"
Role.destroy_all
p "Admin"
Role.create(:name => "Admin")
p "Hotel Owner"
Role.create(:name => "Hotel Owner")
p "Create users:"
User.destroy_all
p "admin trongtran/151288"
User.create(:first_name => "Trong", :last_name => "Tran", :username => "trongtran", :password => "151288", :password_confirmation => "151288", :email => "trongrg@gmail.com", :dob => "15/12/1988", :roles => [Role.find_by_name("Admin")])
