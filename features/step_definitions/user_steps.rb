When /^I edit my account details$/ do
  click_link "Profile"
  fill_in "First name", :with => "newname"
  click_button "Update profile"
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

When /^I edit my password$/ do
  visit "/profile"
  click_link "Change password"
  fill_in "Current password", :with => "please"
  fill_in "Password", :with => "newpass"
  fill_in "Password confirmation", :with => "newpass"
  click_button "Change password"
end

Then /^I should see a password edited message$/ do
  page.should have_content "You updated your password successfully."
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
  click_link "Profile"
  fill_in field.humanize, :with => "#%"
  click_button "Update profile"
end

When /^I edit my account details without an? (.+)/ do |field|
  click_link "Profile"
  fill_in field.humanize, :with => ""
  click_button "Update profile"
end
