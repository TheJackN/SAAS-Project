source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
gem 'bootstrap-sass'

# #1
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# #2
group :development do
  gem 'sqlite3'
  gem 'pry-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Used for encrypting User passwords
gem 'bcrypt'
# Used for sending sensitive data
gem 'figaro', '1.0'
# Used to create and validate user accounts
gem 'devise'
# Used to easily create authorization policies
gem 'pundit'
# Used to make the big bucks
gem 'stripe'
# Used for reading MarkDown
gem 'redcarpet'
