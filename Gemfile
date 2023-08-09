# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.0'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop', require: false
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# front end
gem 'importmap-rails', '~> 1.0'
gem 'stimulus-rails', '~> 1.0'

# 2FA auth
gem 'devise', '~> 4.8'
gem 'devise-two-factor', '~> 4.0'
gem 'rqrcode', '~> 2.1'
# gem 'devise-security'
# gem 'devise_security_extension'
# recaptch
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'recaptcha', require: 'recaptcha/rails'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
