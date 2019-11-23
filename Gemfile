# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'active_model_serializers', '~> 0.10.10'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt', '~> 2.2', '>= 2.2.1'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'
gem 'sqlite3', '~> 1.4'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors', '~> 1.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 5.1', '>= 5.1.1'
  gem 'faker', '~> 2.7'
  gem 'rspec-rails', '~> 4.0.0.beta3'
  %w[rspec-core rspec-expectations rspec-mocks rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'master'
  end
  gem 'rubocop-rails', '~> 2.3', '>= 2.3.2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
