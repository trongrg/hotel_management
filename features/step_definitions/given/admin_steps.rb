Given /^I am signed in as an admin user$/ do
  user = User.make!(:admin)
  sign_in({:username => user.username, :password => "please"})
end

Given /^(\d+) users? exists?$/ do |number|
  number.to_i.times do
    User.make!
  end
end

Given /^the following users exist$/ do |table|
  table.hashes.each do |attrs|
    User.make!(attrs)
  end
end
