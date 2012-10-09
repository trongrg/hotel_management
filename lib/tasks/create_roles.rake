namespace :roles do
  desc "Create roles"
  task :create => :environment do
    puts "Create Hotel Owner role"
    Role.find_or_create_by_name("Hotel Owner")
    puts "Create Staff role"
    Role.find_or_create_by_name("Staff")
  end
end
