Then /^I should see an invalid (.+) message$/ do |field|
  within "#user_#{field.gsub(" ", "_")}_input" do
    page.should have_content "is invalid"
  end
end

Then /^I should see the info of user "([^"]*)"$/ do |username|
  user = User.find_by_username(username)
  [:username, :first_name, :last_name, :phone_number, :dob, :email, :address].each do |attr|
    page.should have_content attr.to_s.humanize
    page.should have_content user.send(attr)
  end
end

Then /^the new user is a (.+)$/ do |role|
  User.last.roles.map(&:name).should include role.titleize
end
