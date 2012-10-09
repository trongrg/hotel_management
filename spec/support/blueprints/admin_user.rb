require 'machinist/active_record'
require 'faker'

AdminUser.blueprint do
  username { "#{Faker::Internet.user_name}#{sn}" }
  password { "please" }
  password_confirmation { "please" }
  email { Faker::Internet.email }
end
