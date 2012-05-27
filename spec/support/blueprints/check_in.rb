require 'machinist/active_record'
CheckIn.blueprint do
  status { CheckIn::STATUS[:active] }
  room { Room.make }
  guest { Guest.make }
  user { User.make }
end
