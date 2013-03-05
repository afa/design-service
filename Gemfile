source 'http://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby
gem 'libv8', :platforms => :ruby

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn', :platforms => :ruby

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'devise'
gem 'haml-rails'
gem 'simple_form'
gem 'nested_form'
gem 'cancan'
gem 'russian'

group :development do
  gem 'sextant'
end

gem 'carrierwave'

# rspec-rails needs to be in the development group so that Rails generators work.
group :test, :development do
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
end