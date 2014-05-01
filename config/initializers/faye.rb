require 'faye'
require 'faye/redis'
Faye::WebSocket.load_adapter('puma')

#NOTE: These default settings are set to run on heroku.
# https://devcenter.heroku.com/articles/ruby-websockets
FayeServer.config.tap do |config|
  config[:mount]=   '/'
  config[:timeout]= Integer(ENV['FAYE_TIMEOUT'] || 25)
  config[:ping]=    Integer(ENV['FAYE_KEEPALIVE'] || 45)

  redis_url = ENV['REDISTOGO_URL'] || ENV['FAYE_REDIS_URL']
  if redis_url
    config[:engine] = { type: Faye::Redis, uri: redis_url }
  end
end
