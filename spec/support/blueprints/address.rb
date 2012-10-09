require 'machinist/active_record'
require 'faker'

Address.blueprint do
  address_1 { Faker::Address.street_address }
  address_2 { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
  country { Faker::Address.country }
  zip_code { Faker::Address.zip_code }
end
