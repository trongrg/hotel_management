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
p "hotel onwer trongrg/123123"
trongrg = User.create(:first_name => "Trong", :last_name => "Tran", :username => "trongrg", :password => "123123", :password_confirmation => "123123", :email => "trongrg@yahoo.com", :dob => "15/12/1988", :roles => [Role.find_by_name("Hotel Owner")])
p "hotel Thien An, trongrg"
hotel = trongrg.hotels.create(:name => "Thien An", :phone_number => "0987654321", :lat => 10.7811, :lng => 106.698)
p "room type Deluxe, hotel Thien An"
room_type = hotel.room_types.create(:name => "Deluxe", :price => "$100")
p "room 101, Deluxe"
room = room_type.rooms.create(:number => "101")
