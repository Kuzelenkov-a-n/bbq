source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"
gem "devise"
gem "rails", "~> 6.1.3", ">= 6.1.3.1"
gem "puma", "~> 5.0"
gem "webpacker", "~> 5.0"
gem "bootsnap", ">= 1.4.4", require: false
gem "turbolinks"
gem "rails-i18n"
gem "devise-i18n"
gem "russian"
gem "carrierwave"
gem "rmagick"
gem "fog-aws"
gem "mailjet"
gem "listen", "~> 3.3"
gem "pundit", "~> 2.1"
gem "recaptcha", require: "recaptcha/rails"
gem "resque", "~> 1.27.4"

group :production do
  gem "pg"
end

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 4.0.1"
  gem "factory_bot_rails"
end

group :development do
  gem "capistrano", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-passenger", require: false
  gem "capistrano-rbenv", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano-resque", require: false
  gem "ed25519", ">= 1.2", "< 2.0"
  gem "bcrypt_pbkdf", ">= 1.0", "< 2.0"
  gem "web-console", ">= 4.1.0"
  gem "rack-mini-profiler", "~> 2.0"
  gem "letter_opener"
end
