source 'http://rubygems.org'

#ruby '2.0.0'
gem 'rails', '~> 3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3' #, platform: :ruby
gem 'mysql2' #, platform: :ruby

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

gem 'devise', '~> 3.0.0.rc'
gem 'haml-rails'
gem 'simple_form'
gem 'nested_form'
gem 'cancan'
gem 'russian'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
gem 'has_scope'
gem 'strong_parameters'
gem 'show_for', '~> 0.3.0.rc'
gem 'enumerize', github: 'brainspec/enumerize'

group :development do
  gem 'sextant'
end

gem 'carrierwave'
gem 'mini_magick'
gem 'draper'

group :test, :development do
  # rspec-rails and factory_girl_rails needs to be in the development group so that Rails generators work.
  gem 'rspec-rails'
  gem 'rspec-given'
  gem 'factory_girl_rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
end
gem 'simplecov', :require => false, :group => :test
#gem 'simplecov-rcov-text'
#gem 'metric_fu'
#gem 'rails_best_practices'

gem 'spork-rails'
gem 'activeadmin'
gem 'rb-readline', "~> 0.5.0", require: 'readline'
#gem 'pry-rails', :group => :development