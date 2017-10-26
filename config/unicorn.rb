# config/unicorn.rb

rails_env = ENV['RAILS_ENV'] || 'production'
app_path = "/var/www/cap-#{rails_env}"
working_directory "#{app_path}/current"
pid               "#{app_path}/shared/tmp/pids/unicorn-#{rails_env}.pid"


worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout Integer(ENV['WEB_TIMEOUT'] || 300)
preload_app true
#listen "/tmp/trailsyserver-#{rails_env}.sock"
listen "/tmp/unicorn-#{rails_env}.sock"

#pid "/tmp/trailsyserver-#{rails_env}.pid"
#stdout_path "/var/www/log/unicorn_trailsyserver-#{rails_env}.log"
#stderr_path "/var/www/log/unicorn_trailsyserver-#{rails_env}.log"
# logging
stderr_path "#{app_path}/shared/log/unicorn-#{rails_env}.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn-#{rails_env}.stdout.log"

# use correct Gemfile on restarts
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker| 
  if defined?(ActiveRecord::Base) 
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10
    config['adapter'] = 'postgis' 
    ActiveRecord::Base.establish_connection(config)
  end 
end

# after_fork do |server, worker|

#   Signal.trap 'TERM' do
#     puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
#   end

#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.establish_connection
# end
