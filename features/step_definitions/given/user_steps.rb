Given /^I am not signed in$/ do
  visit '/sign_out'
end

Given /^I am signed in$/ do
  User.make!(valid_user)
  sign_in valid_user
end

Given /^I exist as a user$/ do
  User.make!(valid_user)
end

Given /^I do not exist as a user$/ do
  User.find(:first, :conditions => { :email => valid_user[:email] }).should be_nil
  visit '/sign_out'
end

Given /^I am signed in as a (.+) with (.+)$/ do |role, fields|
  fields = fields.split(", ")
  attrs = {}
  fields.each do |field|
    key, value = field.split(": ")
    attrs[key.to_sym] = value.gsub("\"", "")
  end
  user = User.make!(role.gsub(' ', '_').to_sym, attrs)
  sign_in(:username => user.username, :password => attrs[:password] || "please")
end

Given /^user "([^"]+)" owns (\d+) hotels?$/ do |username, number|
  number.to_i.times do
    Hotel.make!(:owner => User.find_by_username(username))
  end
end

Given /^user "([^"]+)" has a hotel with name: "([^"]+)"$/ do |username, hotel_name|
  Hotel.make!(:name => hotel_name, :owner => User.find_by_username(username))
end
