When /^I wait for (\d+) seconds?$/ do |number|
  sleep number.to_i
end

When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I follow "([^"]+)"$/ do |link|
  click_link link
end

Then /^I should see "([^"]*)" link$/ do |link|
  page.should have_link(link)
end
