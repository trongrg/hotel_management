Given /^I am not signed in$/ do
  visit '/sign_out'
end

Given /^I am signed in$/ do
  User.make!(valid_user.except(:roles))
  sign_in valid_user
end

Given /^I exist as a user$/ do
  User.make!(valid_user.except(:roles))
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
  parent_object = parent.camelize.constantize.send(find_method_for(parent), parent_name)
  child_attrs = {:"#{attr}" => value}
  parent_object.send("#{child.pluralize}=", [child.camelize.constantize.make(child_attrs)])
  parent_object.save
end

Given /^(#{model_names.join('|')}) "([^"]*)" has (\d+) (#{model_names.map(&:pluralize).join('|')})$/ do |parent, parent_name, number, children|
  parent.gsub!(' ', '_')
  children.gsub!(' ', '_')
  parent_object = parent.camelize.constantize.send(find_method_for(parent), parent_name)
  parent_object.send("#{children}=", number.to_i.times.map { children.singularize.camelize.constantize.make })
  parent_object.save
end
