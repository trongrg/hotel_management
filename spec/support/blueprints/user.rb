require 'machinist/active_record'

User.blueprint do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  username { "#{Faker::Internet.user_name}#{sn}" }
  password { "please" }
  password_confirmation { "please" }
  email { Faker::Internet.email }
  phone_number { Faker::PhoneNumber.phone_number }
  dob { 20.years.ago }
  address1 { Faker::Address.street_address }
  address2 { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
  country { Faker::Address.country }
  zip_code { Faker::Address.zip_code }
end

User.blueprint(:admin) do
  roles { [Role.create(:name => "Admin")] }
end

User.blueprint(:hotel_owner) do
  roles { [Role.create(:name => "Hotel Owner")] }
end

User.blueprint(:staff) do
  roles { [Role.create(:name => "Staff")] }
end
