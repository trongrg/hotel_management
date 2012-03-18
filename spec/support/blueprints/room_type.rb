require 'machinist/active_record'

RoomType.blueprint do
  name { 'Deluxe' }
  price { 199 }
  currency { 'USD' }
end
