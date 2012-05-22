Reservation.blueprint do
  room { Room.make }
  user { User.make(:staff) }
  guest { Guest.make }
  status { Reservation::STATUS[:active] }
  check_in_date { DateTime.now.to_date }
  check_out_date { 3.days.from_now.to_date }
end
