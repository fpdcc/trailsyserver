Rack::Attack.throttle("logins/ip", limit: 20, period: 1.hour) do |req|
  req.ip if req.post? && req.path.start_with?("/users/sign_in")
end

ActiveSupport::Notifications.subscribe("rack.attack") do |name, start, finish, request_id, req|
  puts "Throttled #{req.env["rack.attack.match_discriminator"]}"
end