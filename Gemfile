source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/LiviaBas/EducationApp"
end

# bundler
gem 'bundler', '~> 2.2.11'
# Bundle gem 'rails',
gem 'rails-dom-testing', '~> 6.0.1.'
# rails-dom-testing
gem 'rails-testing', '~>2.0.3'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# active storage
gem 'active storage', '~> 6.1.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use bootstrap 4 stylesheets
gem 'bootstrap', '~> 4.0.0'
# Use jquery rails
gem 'jquery-rails', '~> 4.0.5'
# Use actionpack
gem 'actionpack', '~> 6.1.3'
# Use popper_js
gem 'popper_js', '~> 1.16.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Dependencies for action text
gem "actiontext", require: "action_text"
gem "image_processing"
gem 'webpacker'
gem 'google-cloud-storage'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails', '~> 3.9.1'
  gem 'database_cleaner-active_record'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
