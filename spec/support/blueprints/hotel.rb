require 'machinist/active_record'
require 'faker'

Hotel.blueprint do
  name { Faker::Name.name }
  phone { Faker::PhoneNumber.phone_number }
  address { Address.make }
  location { Location.make }
  owners { [ User.make ] }
end
