Before do
  Role.find_or_create_by_name("Admin")
  Role.find_or_create_by_name("Hotel Owner")
  Role.find_or_create_by_name("Staff")
end
