require 'machinist/active_record'
CheckIn.blueprint do
  status { "available" }
  room { Room.make }
  guest { Guest.make }
  user { User.make }
end
