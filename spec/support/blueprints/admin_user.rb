require 'machinist/active_record'
require 'faker'

AdminUser.blueprint do
  email { Faker::Internet.email }
  password { "please" }
  password_confirmation { "please" }
end
