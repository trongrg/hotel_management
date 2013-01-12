require 'machinist/active_record'
require 'faker'

Room.blueprint do
  name { Faker::Name.name }
  room_type { RoomType.make }
end
