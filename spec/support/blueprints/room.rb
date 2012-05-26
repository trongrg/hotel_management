require 'machinist/active_record'
Room.blueprint do
  number { sn.to_s }
end
