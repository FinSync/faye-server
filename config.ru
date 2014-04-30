require './application'
Dir['./config/initializers/**/*.rb'].each {|f| require f}

if ENV['FORCE_SSL']
  require 'rack/ssl'
  puts "Forcing SSL..."
  use Rack::SSL
end

run FayeServer.new
