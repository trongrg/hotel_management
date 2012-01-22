Given /^I am signed in as an admin user$/ do
  user = User.make!(:admin)
  sign_in({:username => user.username, :password => "please"})
end

Given /^(\d+) users? exists?$/ do |number|
  number.to_i.times do
    User.make!
  end
end

Then /^I should see (\d+) users$/ do |number|
  within "table#users tbody" do
    page.all("tr").count.should == number.to_i
  end
end

Given /^the following users exist$/ do |table|
  table.hashes.each do |attrs|
    User.make!(attrs)
  end
end

When /^I follow "([^"]*)" link of user "([^"]*)"$/ do |link, username|
  user = User.find_by_username(username)
  within "tr#user_#{user.id}" do
    click_link link
  end
end

Then /^I should see the info of user "([^"]*)"$/ do |username|
  user = User.find_by_username(username)
  [:username, :first_name, :last_name, :phone_number, :dob, :email, :address].each do |attr|
    page.should have_content attr.to_s.humanize
    page.should have_content user.send(attr)
  end
end

When /^I edit the user with valid info$/ do
  fill_in "First name", :with => "New First name"
  click_button "Update User"
end

Then /^I should see a successful edit user message$/ do
  page.should have_content "User has been updated successfully."
end

Then /^I should see a successful delete user message$/ do
  page.should have_content "User has been deleted successfully."
end

When /^I edit the user with invalid (.+)$/ do |field|
  fill_in field.humanize, :with => "*&#"
  click_button "Update User"
end

Then /^I should see an invalid (.+) message$/ do |field|
  within "#user_#{field.gsub(" ", "_")}_input" do
    page.should have_content "is invalid"
  end
end

When /^I edit the user with new password$/ do
  fill_in "Password", :with => "newpass"
  fill_in "Password confirmation", :with => "newpass"
  click_button "Update User"
end

When /^I create a new user$/ do
  create valid_user
end

When /^I create a new user without (.+)$/ do |field|
  create valid_user.merge(field.to_sym => "")
end

When /^I create a new user with invalid (.+)$/ do |field|
  create valid_user.merge(field.to_sym => "&^#")
end

Then /^I should see a successful create user message$/ do
  page.should have_content "User has been created successfully."
end
