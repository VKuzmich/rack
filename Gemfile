# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.6.3'

gem 'codebreaker_vk', '~> 1.0', '>= 1.0.3'
gem 'i18n', '~> 1.6'
gem 'puma'
gem 'rack', '~> 2.1'

group :development do
  gem 'bundle-audit', '~> 0.1.0'
  gem 'fasterer', '~> 0.5.1'
  gem 'html2haml'
  gem 'overcommit', '~> 0.48.0'
  gem 'pry', '~> 0.12.2'
  gem 'pry-byebug', '~> 3.7'
  gem 'rubocop', '~> 0.71.0', require: false
  gem 'rubocop-performance', '~> 1.3'
  gem 'rubycritic', require: false
end

group :test do
  gem 'rack-test', '~> 1.1'
  gem 'rspec', '~> 3.8'
  gem 'rubocop-rspec', '~> 1.33'
  gem 'simplecov', '~> 0.16.1'
end
