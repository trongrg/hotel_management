### GIVEN ###
Given /^I am not signed in$/ do
  visit '/sign_out'
end

Given /^I am signed in$/ do
  User.make!(valid_user.merge(:dob => "1988/10/15"))
  sign_in valid_user
end

Given /^I exist as a user$/ do
  User.make!(valid_user)
end

Given /^I do not exist as a user$/ do
  User.find(:first, :conditions => { :email => valid_user[:email] }).should be_nil
  visit '/sign_out'
end

### WHEN ###
When /^I sign out$/ do
  visit '/sign_out'
end

When /^I sign up with valid user data$/ do
  sign_up valid_user
end

When /^I sign up with an invalid email$/ do
  user = valid_user.merge(:email => "notanemail")
  sign_up user
end

When /^I sign up with an invalid username$/ do
  sign_up valid_user.merge(:username => "username #>")
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

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong password$/ do
  user = valid_user.merge(:password => "wrongpass")
  sign_in user
end

When /^I sign in with valid credentials$/ do
  sign_in valid_user
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Sign out"
  page.should_not have_content "Sign up"
  page.should_not have_content "Sign in"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Sign in"
  page.should_not have_content "Sign out"
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see a missing ([^\s]+) message$/ do |field|
  within "#user_#{field}_input" do
    page.should have_content"can't be blank"
  end
end

Then /^I should see a mismatched password message$/ do
  within "#user_password_input" do
    page.should have_content "doesn't match confirmation"
  end
end

Then /^I should see a short password error message$/ do
  within "#user_password_input" do
    page.should have_content "is too short"
  end
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out"
end

Then /^I see an invalid sign in message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end
