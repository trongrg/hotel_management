require 'machinist/active_record'

RoomType.blueprint do
  name { 'Deluxe' }
  price_in_cents { 19900 }
  currency { 'USD' }
end
