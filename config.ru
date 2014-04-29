Dir['./config/initializers/**/*.rb'].each {|f| require f}

# if ENV['FORCE_SSL']
#   require 'rack/ssl-enforcer'
#   use Rack::SslEnforcer
# end

# use Rack::Auth::Basic, "Restricted Area" do |username, password|
#   username == ENV['BASIC_USER'] && password == ENV['BASIC_PASS']
# end

run $finsync_sockets
