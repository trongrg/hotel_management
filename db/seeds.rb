p "Create roles:"
Role.destroy_all
p "Hotel Owner"
Role.create(:name => "Hotel Owner")
p "Create admins:"
AdminUser.destroy_all
p "admin trongtran/123123"
AdminUser.create(:first_name => "Trong", :last_name => "Tran", :username => "trongrg", :password => "123123", :password_confirmation => "123123", :email => "trongrg@yahoo.com", :dob => "15/12/1988")
p "Create users:"
User.destroy_all
p "hotel onwer trongrg/123123"
trongrg = User.create(:first_name => "Trong", :last_name => "Tran", :username => "trongrg", :password => "123123", :password_confirmation => "123123", :email => "trongrg@yahoo.com", :dob => "15/12/1988", :roles => [Role.find_by_name("Hotel Owner")])
p "hotel Thien An, trongrg"
Hotel.destroy_all
hotel = trongrg.hotels.create(:name => "Thien An", :phone_number => "0987654321", :lat => 10.7811, :lng => 106.698, :address_attributes => {:address_1 => "702 Nguyen Van Linh", :city => "Ho Chi Minh City", :country => "VN"} )
p "room type Deluxe, hotel Thien An"
RoomType.destroy_all
room_type = hotel.room_types.create(:name => "Deluxe", :price => "$100")
p "room 101, Deluxe"
Room.destroy_all
room = room_type.rooms.create(:number => "101")
