When /^I edit my account details$/ do
  click_link "Profile"
  fill_in "First name", :with => "newname"
  click_button "Update profile"
end

