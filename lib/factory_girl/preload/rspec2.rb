require 'rspec/core'

RSpec.configure do |config|
  config.add_setting :preload_db_seeds, :default => false
  config.include FactoryGirl::Preload::Helpers
  config.before(:suite) do
    FactoryGirl::Preload.clean
    load("db/seeds.rb", true) if RSpec.configuration.preload_db_seeds
    FactoryGirl::Preload.run
  end

  config.before(:each) do
    FactoryGirl::Preload.reload_factories
  end
end
