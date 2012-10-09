require 'machinist/active_record'

Hotel.blueprint do
  name { Faker::Name.name }
  phone_number { Faker::PhoneNumber.phone_number }
  address { Address.make }
  lat { 10.781135 }
  lng { 106.698457 }
end
