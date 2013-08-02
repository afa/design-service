source 'http://rubygems.org'

#ruby '2.0.0'
gem 'rails', '~> 3.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby
gem 'libv8', '~>3.11.8', :platforms => :ruby

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn', :platforms => :ruby

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'devise', '~> 3.0'
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
gem 'paper_trail', '~> 2'

#gem 'squeel'
gem 'carrierwave'
gem 'mini_magick', github: 'minimagick/minimagick'
gem 'draper'
gem 'activeadmin'

group :development do
  gem 'sextant'
end

group :test, :development do
# rspec-rails and factory_girl_rails needs to be in the development group so that Rails generators work.
  gem 'rspec-rails'

# gem 'pry-rails', :group => :development
  gem 'factory_girl_rails'
end

#group :test do
#  gem 'shoulda-matchers'
#  gem 'capybara'
#end
gem 'simplecov', :require => false, :group => :test
#gem 'simplecov-rcov-text'
#gem 'metric_fu'
#gem 'rails_best_practices'

#gem 'spork-rails'
#gem 'activeadmin'
#gem 'pry-rails', :group => :development
gem 'rb-readline', "~> 0.5.0", require: 'readline'
