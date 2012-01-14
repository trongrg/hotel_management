namespace :db do
  desc 'prepare cucumber database'
  task :clone_cucumber do
    system 'bundle exec rake db:drop RAILS_ENV=cucumber > tmp/null'
    system 'bundle exec rake db:create RAILS_ENV=cucumber >tmp/null'
    system 'bundle exec rake db:schema:load RAILS_ENV=cucumber >tmp/null'
  end
end
Rake::Task['db:test:clone'].enhance do
  Rake::Task['db:clone_cucumber'].invoke
end
