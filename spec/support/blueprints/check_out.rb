require 'machinist/active_record'

CheckOut.blueprint do
  user { User.make }
  guest { Guest.make }
  room { Room.make }
  nights { 1 }
  settlement_type { "Cash" }
end
