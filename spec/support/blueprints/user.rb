require 'machinist/active_record'
require 'faker'

User.blueprint do
  email { Faker::Internet.email }
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  password { "please" }
  password_confirmation { "please" }
  phone { Faker::PhoneNumber.phone_number }
  date_of_birth { 20.years.ago }
  roles { :hotel_owner }
end
