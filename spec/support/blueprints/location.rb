require 'machinist/active_record'
require 'faker'

Location.blueprint do
  latitude { 10.7811 }
  longitude { 106.6984 }
end
