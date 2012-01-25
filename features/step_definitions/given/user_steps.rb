Given /^I am not signed in$/ do
  visit '/sign_out'
end

Given /^I am signed in$/ do
  User.make!(valid_user)
  sign_in valid_user
end

Given /^I exist as a user$/ do
  User.make!(valid_user)
end

Given /^I do not exist as a user$/ do
  User.find(:first, :conditions => { :email => valid_user[:email] }).should be_nil
  visit '/sign_out'
end

Given /^I am signed in as a (.+) with (.+)$/ do |role, fields|
  fields = fields.split(", ")
  attrs = {}
  fields.each do |field|
    key, value = field.split(": ")
    attrs[key.to_sym] = value.gsub("\"", "")
  end
  user = User.make!(role.gsub(' ', '_').to_sym, attrs)
  sign_in(:username => user.username, :password => attrs[:password] || "please")
end

Given /^user "([^"]+)" owns (\d+) hotels?$/ do |username, number|
  number.to_i.times do
    Hotel.make!(:owner => User.find_by_username(username))
  end
end

Given /^(#{model_names.join('|')}) "([^"]+)" has a (#{model_names.join('|')}) with (.+): "([^"]+)"$/ do |parent, parent_name, child, attr, value|
  parent.gsub!(' ', '_')
  child.gsub!(' ', '_')
  parent_object = parent.titleize.constantize.send(find_method_for(parent), parent_name)
  child_attrs = {:"#{attr}" => value}
  parent_object.send("#{child.pluralize}=", [child.titleize.gsub(' ', '').constantize.make(child_attrs)])
  parent_object.save
end

Given /^hotel "([^"]*)" has (\d+) room types$/ do |hotel_name, number|
  number.to_i.times do
    RoomType.make!(:hotel => Hotel.find_by_name(hotel_name))
  end
end
