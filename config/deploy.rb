# config valid only for current version of Capistrano
lock "3.9.0"

YAML.load(File.open(File.dirname(__FILE__) + '/local_env.yml')).each do |key, value|
  ENV[key.to_s] = value unless ENV[key]
end

#set :application, ""
#set :repo_url, "git@example.com:me/my_repo.git"
set :repo_url, ENV['GIT_REPOSITORY']

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/local_env.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "lib/data", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/map", "public/page_cache"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 25

namespace :app do
  task :update_rvm_key do
  	on roles(:app) do
    	execute :gpg, "--keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
  	end
  end
end
before "rvm1:install:rvm", "app:update_rvm_key"
before 'deploy', 'rvm1:install:ruby'  # install/update Ruby
before 'deploy', 'rvm1:install:gems'  # install/update gems from Gemfile into gemset
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
  end
end