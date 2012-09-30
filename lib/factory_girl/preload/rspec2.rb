require 'rspec/core'

RSpec.configure do |config|
  config.add_setting :preload_db_seeds, :default => false
  config.include Factory::Preload::Helpers
  config.before(:suite) do
    Factory::Preload.clean
    load("db/seeds.rb", true) if RSpec.configuration.preload_db_seeds
    Factory::Preload.run
  end

  config.before(:each) do
    Factory::Preload.reload_factories
  end
end
