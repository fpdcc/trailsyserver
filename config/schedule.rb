# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# loading our environment variables and defaults
require 'yaml'
require 'time'
require 'tzinfo'

path = "/var/www/cap-#{ENV['RAILS_ENV']}/current"

if File.exist?(path) # handling cold start
	 env_file = "#{path}/config/local_env.yml"
	 YAML.load(File.open(env_file)).each do |key, value|
      ENV[key.to_s] = value if ENV[key.to_s].nil?
    end if File.exist?(env_file)

    # run our jobs in the right time zone
  	set :job_template, "TZ=\"#{ENV['TIME_ZONE']}\" bash -l -c ':job'"
  	set :output, "#{path}/log/cron_log.log"

  	# https://coderwall.com/p/ahdolq/local-timezone-fix-for-whenever-gem
  	# see: https://github.com/javan/whenever/pull/239
  	# time should be > 03:00
  	def local_time(time)
    	TZInfo::Timezone.get(ENV['TIME_ZONE']).local_to_utc(Time.parse(time))
  	end

  	every :reboot do
    	command "cd #{path} && #{path}/bin/unicorn_rails -c config/unicorn.rb -E #{ENV['RAILS_ENV']} -D "
    	#command "cd #{path} && bundle exec #{path}/bin/delayed_job start"
  	end

    every :day, at: local_time("4:00am") do
      runner "Alert.expire_alerts_json"
    end

end

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
