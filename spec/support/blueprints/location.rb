require 'machinist/active_record'
require 'faker'

Location.blueprint do
  latitude { 10.781135 }
  longitude { 106.698457 }
end
