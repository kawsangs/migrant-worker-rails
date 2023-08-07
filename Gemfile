# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.7", ">= 6.1.7.4"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 5.0"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem "webpacker", "~> 5.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

gem "haml-rails",     "~> 2.0"
gem "jquery-rails",   "~> 4.4.0"
gem "bootstrap",      "~> 4.5.2"
gem "coffee-rails",   "~> 5.0.0"

gem "simple_form",    "~> 5.1.0"
gem "pundit",         "~> 2.1.0"
gem "pagy",           "~> 3.5"
gem "carrierwave",    "~> 2.1.1"

gem "devise", "~> 4.9.2"
gem "omniauth-rails_csrf_protection", "~> 1.0.1"
gem "omniauth-google-oauth2", "~> 1.0.0"

gem "sentry-raven",   "~> 3.0.0"
gem "awesome_nested_set", "~> 3.4.0"
gem "active_model_serializers", "~> 0.10.12"
gem "jquery-fileupload-rails", "~> 1.0.0"

gem "sidekiq", "~> 7.0.8"
gem "sidekiq-scheduler", "~> 5.0.3"

gem "countries", "~> 3.1"
gem "cocoon", "~> 1.2", ">= 1.2.15"

# push notification
gem "googleauth", "1.7.0"
gem "fcm", "1.0.8"

gem "roo", "~> 2.8.3"
gem "spreadsheet", "~> 1.2.9"
# Write excel
gem "caxlsx"
gem "caxlsx_rails"

gem "net-http"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 4.0.2"
  gem "factory_bot_rails", "~> 6.1.0"
  gem "ffaker", "~> 2.14.0"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 4.1.0"
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem "rack-mini-profiler", "~> 2.0"
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "annotate", "~> 3.1.0"
  gem "rubocop-rails"
  gem "rubocop-performance"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "shoulda-matchers",       "~> 4.3.0"
  gem "database_cleaner-active_record", "~> 1.8.0"
  gem "rspec-sidekiq"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
