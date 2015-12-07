RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  #config.include Mongoid::Matchers, type: :model
  #config.include AuthenticationHelpers, type: :controller
end
