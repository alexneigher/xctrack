source 'https://rubygems.org'
ruby '2.6.6'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0'
# Use sqlite3 as the database for Active Record

#Use Postgres for DB
gem 'pg', '~> 0.20'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem "haml", ">= 5.0.0"

gem 'httparty'
gem 'nokogiri', '~> 1.6', '>= 1.6.8'

gem "twitter-bootstrap-rails"
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem "faker"

gem 'dotenv-rails'

gem 'aws-sdk-s3', '~> 1'

gem 'letter_opener'

gem 'airbrake', '~> 6.2'

gem "font-awesome-rails"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'devise'
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'pry'
  gem 'database_cleaner'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

