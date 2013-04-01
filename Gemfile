source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'simple_form'
gem 'haml-rails'
gem "less-rails", '2.2.3' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'devise'
gem 'thin' 
gem 'nokogiri'
gem "twitter-bootstrap-rails", '2.1.3'


group :production do
  gem 'pg'
end

group :test, :development do
  gem 'mysql'
  gem 'database_cleaner'
  gem 'spork'
  gem 'quiet_assets'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'rb-inotify', '~> 0.9'
  gem 'factory_girl_rails'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'therubyracer', '~> 0.10.2'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
