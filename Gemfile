source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use PostgreSQL as the database for Active Record and MySQL on deployment
# gem 'pg'
# gem 'mysql2'
gem 'sqlite3'
gem 'i18n', github: 'svenfuchs/i18n'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'aws-sdk', '~> 2'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# HAML generator
gem 'haml-rails'
gem 'RedCloth'
gem 'will_paginate'
gem 'yaml_db'
gem 'bcrypt', '~> 3.1.5', require: "bcrypt"
gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'
gem 'browser'
gem 'geocoder'
gem 'invisible_captcha'
gem 'decent_exposure'
gem 'stringex'
gem 'seed_dump'
gem 'activerecord-import'

group :production do
  gem 'passenger'
end

group :development do
  gem 'puma'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem "rack-livereload"
  gem "guard-livereload"
end

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rspec-rails', '~> 3.2.0'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
end

group :test do
  gem 'minitest-reporters'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'launchy'
  gem 'faker'
  gem 'fuubar'
  gem 'selenium-webdriver'
end
