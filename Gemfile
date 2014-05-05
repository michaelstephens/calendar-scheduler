source 'https://rubygems.org'

gem 'rails', '4.0.4'

gem 'bootstrap-sass'
gem 'chronic'
gem "chronic_ping"
gem 'coffee-rails'
gem 'declarative_authorization'
gem 'font-awesome-rails'
gem 'gon'
gem 'humanity', '>= 0.2.1'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pinglish'
gem 'kaminari-bootstrap', '~> 3.0.1'
gem 'pretender'
gem 'possessive'
gem 'rack-cas', '>= 0.8.1'
gem 'rails_config'
# Declarative Authorization backend needs ruby parser to work nicely with sidekiq
gem 'ruby_parser'
gem 'sass-rails'
gem 'slim-rails' # for slim generators instead of erb
gem 'therubyracer'
gem 'thor'
gem 'turbolinks'
gem 'uglifier'
gem 'version'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'letter_opener'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'phantomjs'
  gem 'pry'
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'thin'
  gem 'teaspoon'
end

group :development, :staging, :test do
  gem 'faker'
end

group :development, :staging, :production do
  gem 'newrelic_rpm'
end

group :test do
  gem 'sqlite3'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-teaspoon'
  gem 'launchy'
  gem 'rspec-html-matchers'
  gem "rspec-sidekiq"
  gem 'shoulda-matchers'
  gem 'spork-rails', github: 'sporkrb/spork-rails', ref: '3224f84d8c31fcb0894e9a43f6c3ac67e3aa0d71'
end

group :staging, :production do
  gem 'mysql2'
  gem 'rack-ssl'
end

group :production do
  gem 'exception_notification'
end