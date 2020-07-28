require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

run ApplicationController

desc 'drop into the Pry console'
task :console => :environment do
  Pry.start
end