# config/unicorn.rb

rails_env = ENV['RAILS_ENV'] || 'production'

worker_processes Integer(ENV['WEB_CONCURRENCY'] || 3)
timeout Integer(ENV['WEB_TIMEOUT'] || 300)
preload_app true
listen "/tmp/trailsyserver-#{rails_env}.sock"
pid "/tmp/trailsyserver-#{rails_env}.pid"
stdout_path "/var/www/log/unicorn_trailsyserver.log"
stderr_path "/var/www/log/unicorn_trailsyserver.log"

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
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
