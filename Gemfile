# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.3", ">= 6.0.3.5"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 4.3"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 4.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

gem "devise", github: "heartcombo/devise", branch: "ca-omniauth-2"
gem "haml-rails",     "~> 2.0"
gem "jquery-rails",   "~> 4.4.0"
gem "bootstrap",      "~> 4.5.2"
gem "coffee-rails",   "~> 5.0.0"

gem "simple_form",    "~> 5.1.0"
gem "pundit",         "~> 2.1.0"
gem "pagy",           "~> 3.5"
gem "carrierwave",    "~> 2.1.1"

gem "omniauth-google-oauth2", "~> 1.0.0"
gem "omniauth-rails_csrf_protection", "~> 1.0.0"

gem "sentry-raven",   "~> 3.0.0"
gem "awesome_nested_set", "~> 3.4.0"
gem "active_model_serializers", "~> 0.10.12"
gem "jquery-fileupload-rails", "~> 1.0.0"

gem "sidekiq", "~> 6.2.1"
gem "sidekiq-scheduler", "~> 3.0.1"

gem 'countries', '~> 3.1'
gem 'cocoon', '~> 1.2', '>= 1.2.15'
gem 'active_storage_validations', '~> 0.9.3'
gem 'mini_magick', '>= 4.9.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 4.0.2"
  gem "factory_bot_rails", "~> 6.1.0"
  gem "ffaker", "~> 2.14.0"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "annotate", "~> 3.1.0"
  gem "rubocop-rails"
  gem "rubocop-performance"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
  gem "shoulda-matchers",       "~> 4.3.0"
  gem "database_cleaner-active_record", "~> 1.8.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
