Then /^I should be signed in$/ do
  page.should have_link "Sign out"
  page.should have_no_link "Sign up"
  page.should have_no_link "Sign in"
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should be signed out$/ do
  page.should have_link "Sign up"
  page.should have_link "Sign in"
  page.should have_no_link "Sign out"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out"
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see a missing ([^']+)'s (.+) message$/ do |model, field|
  within "##{model.gsub(' ', '_')}_#{field.gsub(" ", "_")}_input" do
    page.should have_content "can't be blank"
  end
end

Then /^I should see a invalid ([^']+)'s (.+) message$/ do |model, field|
  within "##{model.gsub(' ', '_')}_#{field.gsub(" ", "_")}_input" do
    page.should have_content "is invalid"
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

Then /^I see an invalid sign in message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see a successful ([^\s]+) (#{model_names.join("|")}|password|account) message$/ do |action, object|
  page.should have_content "#{object.humanize} has been #{action}d successfully."
end

Then /^I should see (\d+) (#{model_names.map(&:pluralize).join('|')})$/ do |number, model|
  if model == 'hotels'
    within "#hotels .tabular_data" do
      page.all("ul.tbody>li").count.should == number.to_i
    end
  else
    within "table##{model.pluralize.gsub(' ', '_')} tbody" do
      page.all("tr").count.should == number.to_i
    end
  end
end

Then /^the "([^"]*)" field should have value$/ do |field|
  wait_for true do
    page.find_field(field).value.present?
  end
end

Then /^I should see the google map marker points to my hotel's location$/ do
  page.find_field("Lat").value.to_f.should be_within(0.001).of(page.evaluate_script("GoogleMap.marker.getPosition().lat()"))
  page.find_field("Lng").value.to_f.should be_within(0.001).of(page.evaluate_script("GoogleMap.marker.getPosition().lng()"))
end

Then /^I should (not )?see (a|the) create (#{model_names.join("|")}) popup dialog$/ do |negate, a_the, model_name|
  form = "#facebox form#new_#{model_name}"
  if negate
    begin
      page.should have_no_css form
    rescue
      page.find(form).should_not be_visible
    end
  else
    page.find(form).should be_visible
  end
end

Then /^I should see the newly created (#{model_names.join('|')})$/ do |model|
  if model == 'hotel'
    within "#hotels .tabular_data" do
      page.all("ul.tbody>li").count.should == 1
    end
  else
    pending
  end
end
