require 'machinist/active_record'
require 'faker'

Location.blueprint do
  latitude { 123 }
  longitude { 123 }
end
