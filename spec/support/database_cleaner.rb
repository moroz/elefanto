RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, js: true) do
    DatabaseCleaner.start
  end

  config.after(:each, js: true) do
    DatabaseCleaner.clean
  end
end
