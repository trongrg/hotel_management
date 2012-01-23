Given /^I am signed in as a hotel owner with (.+)$/ do |fields|
  fields = fields.split(", ")
  attrs = {}
  fields.each do |field|
    key, value = field.split(": ")
    attrs[key.to_sym] = value.gsub("\"", "")
  end
  user = User.make!(:hotel_owner, attrs)
  sign_in(:username => user.username, :password => attrs[:password] || "please")
end

Given /^there are (\d+) hotels? which belong to user "([^"]+)"$/ do |number, username|
  number.to_i.times do
    Hotel.make!(:owner => User.find_by_username(username))
  end
end

Then /^I should see (\d+) hotels$/ do |number|
  within "table#hotels tbody" do
    page.all("tr").count.should == number.to_i
  end
end

When /^I follow "([^"]+)" link of hotel "([^"]+)"$/ do |link, name|
  hotel = Hotel.find_by_name(name)
  within "table#hotels tbody tr#hotel_#{hotel.id}" do
    click_link link
  end
end

Given /^user "([^"]+)" has a hotel with name: "([^"]+)"$/ do |username, hotel_name|
  Hotel.make!(:name => hotel_name, :owner => User.find_by_username(username))
end

Then /^I should see a successful delete hotel message$/ do
  page.should have_content "Hotel has been deleted successfully."
end

When /^I edit the (.+) without a (.+)$/ do |model, field|
  fill_in field.humanize, :with => ""
  click_button "Update #{model.titleize}"
end

When /^I edit the hotel with valid info$/ do
  fill_in "Name", :with => "New Name"
  click_button "Update Hotel"
end
