require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end



# desc 'drop into the Pry console'
# task :console => :environment do
#   Pry.start
# end
use Rack::MethodOverride
use UserController
use BlogController
run ApplicationController
