require 'machinist/active_record'

CheckIn.blueprint do
  hotel { Hotel.make }
  rooms { [Room.make] }
  guest
  adults { 2 }
  children { 0 }
end

CheckIn.blueprint(:expired) do
  hotel { Hotel.make }
  rooms { [Room.make] }
  guest
  adults { 2 }
  children { 0 }
  status { CheckIn::STATUSES[:expired] }
end
