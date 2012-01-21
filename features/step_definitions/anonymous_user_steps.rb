### UTILITY METHODS ###
def valid_user
  @user ||= { :first_name => "Trong", :last_name => "Tran", :username => "trongtran",
    :email => "trongrg@gmail.com", :password => "please", :password_confirmation => "please",
    :dob => {:"1i" => "1988", :"2i" => "December", :"3i" => "15"},
    :phone_number => "01694622095", :address1 => "702 Nguyen Van Linh", :address2 => "District 7",
    :state => "Ho Chi Minh City", :country => "Viet Nam", :zip_code => "12345"
  }
end

def sign_up user
  visit '/sign_up'
  user.each do |field, value|
    field = field.to_s.humanize
    case field
    when "Country"
      select value, :from => field
    when "Dob"
      value.each do |k, v|
        select v, :from => "user_dob_#{k}"
      end
    else
      fill_in field, :with => value
    end
  end
  click_button "Sign up"
end

def sign_in user
  visit '/sign_in'
  fill_in "Username", :with => user[:username]
  fill_in "Password", :with => user[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not signed in$/ do
  visit '/sign_out'
end

Given /^I am signed in$/ do
  sign_up valid_user
end

Given /^I exist as a user$/ do
  sign_up valid_user
  visit '/sign_out'
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

When /^I sign up without a (.+)$/ do |field|
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

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "Name", :with => "newname"
  fill_in "Current password", :with => valid_user[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/'
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

Then /^I should see a succesfull sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  within "#user_email_input" do
    page.should have_content "is invalid"
  end
end

Then /^I should see an invalid username message$/ do
  within "#user_username_input" do
    page.should have_content "is invalid. Only letters, digits, periods and underscores are allowed"
  end
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

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  page.should have_content valid_user[:name]
end

