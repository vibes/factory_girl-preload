RAILS_ENV = "test"
RAILS_ROOT = File.dirname(__FILE__) + "/support/app"

require 'vibes-rspec-rails23'
require "rspec/autorun"

require 'active_record'
require "factory_girl"
require "factory_girl-preload"

ActiveRecord::Base.configurations = YAML::load(ERB.new(IO.read(File.join(RAILS_ROOT, 'config/database.yml'))).result)
ActiveRecord::Base.establish_connection :test

load File.dirname(__FILE__) + "/support/app/db/schema.rb"

require File.dirname(__FILE__) + "/support/factories"

DatabaseCleaner[:active_record].strategy = :truncation

RSpec.configure do |config|
  config.enable_reasonable_defaults!
end

FactoryGirl::Preload.run
