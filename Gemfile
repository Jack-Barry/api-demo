source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',    '~> 5.1.4'
gem 'pg',       '~> 0.18'
gem 'puma',     '~> 3.7'
gem 'figaro'
gem 'rack-cors'
gem 'bcrypt'
gem 'jwt'

group :development, :test do
  gem 'byebug',                        platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails',        '~> 3.5'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers',   '~> 3.1'
  gem 'database_cleaner'
  gem 'faker'
end

group :development do
  gem 'listen',                      '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen',       '~> 2.0.0'
  gem 'guard'
  gem 'guard-rspec', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
