When /^I sign out$/ do
  visit '/sign_out'
end

When /^I sign up with valid user data$/ do
  sign_up valid_user
end

When /^I sign up with an invalid (.+)$/ do |field|
  user = valid_user.merge(field.gsub(" ", "_") => "#*$")
  sign_up user
end

When /^I sign up with a short password$/ do
  user = valid_user.merge(:password => "1")
  sign_up user
end

When /^I sign up without an? (.+)$/ do |field|
  if field == "address"
    user = valid_user.except(:address_attributes)
  else
    user = valid_user.merge(field => "")
  end
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

When /^I sign in with password "([^"]+)"$/ do |password|
  sign_in valid_user.merge(:password => password)
end

When /^I edit my profile$/ do
  click_link "Profile"
  fill_fields valid_user.except(:password, :password_confirmation).merge(:first_name => "new_name")
  click_button "Update Profile"
end

When /^I change my password to "([^"]+)"$/ do |new_password|
  visit "/profile"
  click_link "Change password"
  fill_in "Current password", :with => "please"
  fill_in "user_password", :with => new_password
  fill_in "user_password_confirmation", :with => new_password
  click_button "Change password"
end

When /^I set my password to "([^"]+)"$/ do |new_password|
  fill_in "user_password", :with => new_password
  fill_in "user_password_confirmation", :with => new_password
  click_button "Change password"
end

When /^I update my password with mismatched password and confirmation$/ do
  visit "/profile"
  click_link "Change password"
  fill_in "Current password", :with => "please"
  fill_in "user_password", :with => "newpass"
  fill_in "user_password_confirmation", :with => "notmatch"
  click_button "Change password"
end

When /^I update my password with invalid current password$/ do
  visit "/profile"
  click_link "Change password"
  fill_in "Current password", :with => "invalidpass"
  fill_in "user_password", :with => "newpass"
  fill_in "user_password_confirmation", :with => "newpass"
  click_button "Change password"
end

When /^I edit my profile with invalid (.+)$/ do |field|
  visit "/profile"
  fill_in field.humanize, :with => "#%"
  click_button "Update Profile"
end

When /^I edit my profile without an? (.+)/ do |field|
  if field == "address"
    user = valid_user.except(:password_confirmation, :password).merge(:address_attributes => {:line1 => "", :line2 => "", :city => "", :state => "", :zip => "", :country => nil})
  else
    user = valid_user.except(:password_confirmation, :password).merge(field => "")
  end
  visit "/profile"
  fill_fields user
  click_button "Update Profile"
end

When /^I edit the (.+) without an? (.+)$/ do |model, field|
  case field.downcase
  when "room type"
    select "", :from => field.humanize
  when "location"
    fill_in "Latitude", :with => ""
    fill_in "Longitude", :with => ""
  else
    fill_in field.humanize, :with => ""
  end
  click_button "Update #{model.humanize}"
end

#When /^I edit the hotel with valid info$/ do
  #fill_in "Name", :with => "New Name"
  #click_button "Update Hotel"
#end

When /^I click and drag the google map marker to the right$/ do
  lat = page.evaluate_script("GoogleMap.marker.getPosition().lat()")
  lng = page.evaluate_script("GoogleMap.marker.getPosition().lng()") + 0.01
  page.execute_script("GoogleMap.marker.setPosition(new google.maps.LatLng(#{lat}, #{lng}))")
  page.execute_script("google.maps.event.trigger(GoogleMap.marker, 'mouseup')")
end

When /^I fill in the hotel address$/ do
  fill_fields(:line1 => "702 Nguyen Van Linh Street", :line2 => "District 7", :city => "Ho Chi Minh City", :country => "Viet Nam")
end

When /^I send an invitation to "([^"]*)"$/ do |email|
  fill_fields({:email => email})
  click_on "Send an invitation"
end

When /^I update my info/ do
  fill_fields valid_user.except(:email)
  click_on "Update info"
end

When /^I reset my password$/ do
  visit "/sign_in"
  click_link "Forgot your password?"
  fill_in "Email", :with => User.last.email
  click_button "Send me reset password instructions"
end

When /^I follow my reset password link$/ do
  token = User.last.reset_password_token
  visit "/users/password/edit?reset_password_token=#{token}"
end

When /^I remove my address$/ do
  page.execute_script("$('#remove_address_link').click()")
  click_button "Update Profile"
end

When /^I create a new (#{model_names.join("|")})$/ do |model|
  model.gsub!(" ", "_")
  send("create_#{model}", send("valid_#{model}"))
end

When /^I create a new (#{model_names.join("|")}) without an? (.+)$/ do |model, field|
  model.gsub!(" ", "_")
  send("create_#{model}", send("valid_#{model}").merge(field.gsub(' ', '_') => ""))
end

When /^I create a new (#{model_names.join('|')}) with an invalid (.+)$/ do |model, field|
  send("create_#{model}", send("valid_#{model}").merge(field => "*#&"))
end

When /^I follow "([^"]*)" link of (.+) "([^"]*)"$/ do |link, model, name|
  object = model.gsub(' ', '_').camelize.constantize.send(find_method_for(model), name)
  within "##{model.gsub(' ', '_')}_#{object.id}" do
    click_link link
  end
end

When /^I edit the (#{model_names.join('|')}) with valid info$/ do |model|
  fill_fields send("valid_#{model.gsub(' ', '_')}")
  click_button "Update #{model.humanize}"
end

When /^I edit the (#{model_names.join('|')}) with invalid (.+)$/ do |model, field|
  fill_in field.humanize, :with => "*&#"
  click_button "Update #{model.humanize}"
end

When /^I edit the user with new password$/ do
  fill_in "Password", :with => "newpass"
  fill_in "Password confirmation", :with => "newpass"
  click_button "Update User"
end

When /^I create a new (#{model_names.join('|')}) with (.+)$/ do |model, attrs|
  attrs = Hash[attrs.split(", ").map { |attr_value| attr, value = attr_value.split(": "); [attr, value.gsub("\"", "")] }]
  fill_fields(send("valid_#{model}").merge(attrs))
  click_button "Create #{model.humanize}"
end
