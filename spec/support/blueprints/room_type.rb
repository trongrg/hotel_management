require 'machinist/active_record'
require 'faker'

RoomType.blueprint do
  name { Faker::Name.name }
  price_cents { 1000 }
  currency { "USD" }
end
