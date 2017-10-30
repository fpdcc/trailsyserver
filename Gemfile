source 'https://rubygems.org'

# ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.3'

gem 'actionpack-page_caching'

# Use postgresql as the database for Active Record
gem 'pg'

#gem 'left_join'
#gem 'active_record_union'

# bootstrap
gem "twitter-bootstrap-rails"
gem 'momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'
#gem 'bootstrap-datepicker-rails'
gem 'will_paginate', '~> 3.1.1'
gem 'will_paginate-bootstrap'

gem 'validates_overlap' # Date overlap

gem 'rack-cors', :require => 'rack/cors'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3.1'
gem 'jquery-ui-rails', '~> 5.0.5'
#gem 'bootstrap-editable-rails'
#gem 'best_in_place', '~> 3.1.1'



# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5.0.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'activerecord-postgis-adapter'
gem 'rgeo'
gem 'rgeo-geojson'
gem 'oj'
gem 'unicorn'
gem 'devise'
# Current released version of devise_security_extension does not work with 5.1. Need to use master
gem 'devise_security_extension', git: 'https://github.com/phatworx/devise_security_extension.git'
gem 'rails_email_validator'
gem 'pundit'
gem 'rubyzip'
gem 'paperclip', '~> 3.0'
gem 'aws-sdk'
gem 'ransack'
gem 'rack-attack'
gem 'paper_trail'

gem 'delayed_job_active_record'
gem "daemons"
# cron jobs for backups and sending reminders
gem 'whenever', require: false

group :development, :development_fpcc do
  gem 'sshkit', '~> 1.13.1'
  gem "capistrano", "~> 3.7"
  gem 'capistrano-rails', '~> 1.2'
  #gem 'capistrano-postgresql', '~> 4.2.0'
  #gem 'capistrano-postgresql', :github => 'nmcalabroso/capistrano-postgresql', :ref => '16f4a289c0e07e066d6a3dccb4fb6aa26c4e7a6d'
  #gem 'capistrano3-unicorn'
  gem 'capistrano-bundler', '~> 1.2', require: false
  gem 'rvm1-capistrano3', require: false
  gem 'capistrano-rake', require: false
  gem 'capistrano3-unicorn'

  # this whole group makes finding performance issues much friendlier
  gem 'rack-mini-profiler'
  gem 'flamegraph'
  gem 'stackprof' # ruby 2.1+ only
  gem 'memory_profiler'
  gem 'ruby-prof'

  # n+1 killer.
  gem 'bullet'
  gem 'query_diet'

  # what attributes does this model actually have?
  gem 'annotate'

  #a console in your tests, to find out what's actually happening
  gem 'pry-rails'

  # a console in your browser, when you want to interrogate views.
  gem 'web-console'

end


group :testing do
  # mock tests w/mocha
  gem 'mocha', :require => false

  gem 'sqlite3', :platform => [:ruby, :mswin, :mingw]

  # for JRuby
  gem 'jdbc-sqlite3', :platform => :jruby
  gem 'memory_test_fix' # in memory DB, for the speedy

  # generate fake data w/faker: http://rubydoc.info/github/stympy/faker/master/frames
  gem 'faker'
  gem 'rubocop', require: false
end

group :development, :development_fpcc, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-minitest'
  gem 'guard-rubocop'
  gem 'guard-bundler', require: false
  gem 'capybara'
  gem 'capybara-email'
  gem 'pry'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', '~> 3.1.1', require: false
  gem 'database_cleaner'
  gem 'poltergeist'
end


group :production do
  #gem 'rails_12factor'
  #gem 'heroku_rails_deflate'
end
