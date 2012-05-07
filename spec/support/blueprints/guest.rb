require 'machinist/active_record'
require 'faker'

Guest.blueprint do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  national_id_number { rand(1e9) }
end
