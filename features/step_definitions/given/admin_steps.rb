Given /^I am signed in as an admin user$/ do
  user = User.make!(:admin)
  sign_in({:username => user.username, :password => "please"})
end

Given /^(\d+) users? exists?$/ do |number|
  number.to_i.times do
    User.make!
  end
end

Given /^the following users exist$/ do |table|
  table.hashes.each do |attrs|
    User.make!(attrs)
  end
end

Given /^an? (#{model_names.join('|')}) exists with:$/ do |model, table|
  attributes = table.rows_hash
  attributes.keys.each do |key|
    attributes[key.gsub(' ', '_').downcase] = attributes.delete(key)
  end
  attributes[:dob] = DateTime.parse(attributes[:dob]) if attributes[:dob]
  model.gsub(' ', '_').camelize.constantize.send(:make!, attributes)
end

Given /^(#{model_names.join('|')}) "([^"]*)" is a (.+) of (#{model_names.join('|')}) "([^"]*)"$/ do |model1, model_name1, relation, model2, model_name2|
  object1 = model1.gsub(' ','_').camelize.constantize.send(find_method_for(model1), model_name1)
  object2 = model2.gsub(' ','_').camelize.constantize.send(find_method_for(model2), model_name2)
  object2.send(relation.pluralize.gsub(' ', '_') + '=', [object1])
  object2.save
end
