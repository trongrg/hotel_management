require 'machinist/active_record'
require 'faker'

Address.blueprint do
  line1 { "line1" }
  city { "Ho Chi Minh City" }
  country { "VN" }
end
