When /^I follow "([^"]*)" link of (.+) "([^"]*)"$/ do |link, model, name|
  object = model.titleize.constantize.send(find_method_for(model), name)
  within "tr##{model}_#{object.id}" do
    click_link link
  end
end

When /^I edit the user with valid info$/ do
  fill_in "First name", :with => "New First name"
  click_button "Update User"
end

When /^I edit the (.+) with invalid (.+)$/ do |model, field|
  fill_in field.humanize, :with => "*&#"
  click_button "Update #{model.titleize}"
end

When /^I edit the user with new password$/ do
  fill_in "Password", :with => "newpass"
  fill_in "Password confirmation", :with => "newpass"
  click_button "Update User"
end

When /^I create a new ([^\s]+)$/ do |model|
  send("create_#{model}", send("valid_#{model}".to_sym))
end

When /^I create a new (.+) without an? (.+)$/ do |model, field|
  send("create_#{model}", send("valid_#{model}".to_sym).merge(field.to_sym => ""))
end

When /^I create a new (.+) with an invalid (.+)$/ do |model, field|
  send("create_#{model}", send("valid_#{model}".to_sym).merge(field.to_sym => "*#&"))
end
