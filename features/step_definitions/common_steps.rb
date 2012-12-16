When /^I wait for (\d+) seconds?$/ do |number|
  sleep number.to_i
end

When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Given /^I am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I follow "([^"]+)"$/ do |link|
  click_link link
end

Then /^I should see "([^"]*)" link$/ do |link|
  page.should have_link(link)
end

Then /^I should be on (.+)$/ do |page_name|
  current_path.should == path_to(page_name)
end

When /^I (accept|dismiss) the confirm box$/ do |action|
  if Capybara.current_driver != :rack_test
    page.driver.browser.switch_to.alert.send(action)
  end
end

Then /^I should (not |)see "([^"]+)"$/ do |neg, text|
  if neg.present?
    page.should have_no_content(text)
  else
    page.should have_content(text)
  end
end

When /^I sign in as "([^"]*)\/([^"]*)"$/ do |username, password|
  sign_in({:username => username, :password => password})
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |field, value|
  page.fill_in field, :with => value
end
