require 'machinist/active_record'

Reservation.blueprint do
  hotel { Hotel.make }
  rooms { [Room.make] }
  guest
  check_in_date { DateTime.now.to_date }
  check_out_date { 3.days.from_now.to_date }
end

