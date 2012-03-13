When /^I follow "([^"]*)" link of (.+) "([^"]*)"$/ do |link, model, name|
  object = model.gsub(' ', '_').camelize.constantize.send(find_method_for(model), name)
  within "tr##{model.gsub(' ', '_')}_#{object.id}" do
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

When /^I create a new (#{model_names.join("|")})$/ do |model|
  model.gsub!(" ", "_")
  send("create_#{model}", send("valid_#{model}".to_sym))
end

When /^I create a new (#{model_names.join("|")}) without an? (.+)$/ do |model, field|
  model.gsub!(" ", "_")
  send("create_#{model}", send("valid_#{model}".to_sym).merge(field.gsub(' ', '_').to_sym => ""))
end

When /^I create a new (.+) with an invalid (.+)$/ do |model, field|
  send("create_#{model}", send("valid_#{model}".to_sym).merge(field.to_sym => "*#&"))
end

When /^I create a new room with a new room type$/ do
  create_room valid_room.merge(:room_type => "Deluxe"), true
end

When /^I create a new room with room type "([^"]*)"$/ do |room_type|
  create_room valid_room.merge(:room_type => room_type)
end
