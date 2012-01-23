require 'machinist/active_record'

Hotel.blueprint do
  name { Faker::Name.name }
  phone_number { Faker::PhoneNumber.phone_number }
  address1 { Faker::Address.street_address }
  address2 { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
  country { "Viet Nam" }
  zip_code { Faker::Address.zip_code }
  lat { rand()*10 }
  lng { rand()*10 }
end
