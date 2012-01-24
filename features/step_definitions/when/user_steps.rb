When /^I sign out$/ do
  visit '/sign_out'
end

When /^I sign up with valid user data$/ do
  sign_up valid_user
end

When /^I sign up with an invalid (.+)$/ do |field|
  user = valid_user.merge(field.gsub(" ", "_").to_sym => "#*$")
  sign_up user
end

When /^I sign up with a short password$/ do
  user = valid_user.merge(:password => "1")
  sign_up user
end

When /^I sign up without an? (.+)$/ do |field|
  user = valid_user.merge(field.to_sym => "")
  sign_up user
end

When /^I sign up with a mismatched password confirmation$/ do
  user = valid_user.merge(:password_confirmation => "please123")
  sign_up user
end

When /^I sign in with a wrong password$/ do
  user = valid_user.merge(:password => "wrongpass")
  sign_in user
end

When /^I sign in with valid credentials$/ do
  sign_in valid_user
end

When /^I edit my account details$/ do
  click_link "Profile"
  fill_in "First name", :with => "newname"
  click_button "Update profile"
end

When /^I edit my password$/ do
  visit "/profile"
  click_link "Change password"
  fill_in "Current password", :with => "please"
  fill_in "Password", :with => "newpass"
  fill_in "Password confirmation", :with => "newpass"
  click_button "Change password"
end

When /^I edit my password with mismatched password and confirmation$/ do
  visit "/profile"
  click_link "Change password"
  fill_in "Current password", :with => "please"
  fill_in "Password", :with => "newpass"
  fill_in "Password confirmation", :with => "notmatch"
  click_button "Change password"
end

When /^I edit my password with invalid current password$/ do
  visit "/profile"
  click_link "Change password"
  fill_in "Current password", :with => "invalidpass"
  fill_in "Password", :with => "newpass"
  fill_in "Password confirmation", :with => "newpass"
  click_button "Change password"
end

When /^I edit my account details with invalid (.+)$/ do |field|
  visit "/profile"
  fill_in field.humanize, :with => "#%"
  click_button "Update profile"
end

When /^I edit my account details without an? (.+)/ do |field|
  visit "/profile"
  fill_in field.humanize, :with => ""
  click_button "Update profile"
end

When /^I edit the (.+) without a (.+)$/ do |model, field|
  fill_in field.humanize, :with => ""
  click_button "Update #{model.titleize}"
end

When /^I edit the hotel with valid info$/ do
  fill_in "Name", :with => "New Name"
  click_button "Update Hotel"
end
