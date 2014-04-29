require 'faye'
require 'faye/redis'

#NOTE: These default settings are set to run on heroku.
# https://devcenter.heroku.com/articles/ruby-websockets
timeout   = Integer(ENV['FAYE_TIMEOUT'] || 25)
keepalive = Integer(ENV['FAYE_KEEPALIVE'] || 45)

faye_config = { mount: '/', timeout: timeout, ping: keepalive }

if ENV['FAYE_REDIS_URL']
  faye_config[:engine] = { type: Faye::Redis, uri: ENV['FAYE_REDIS_URL'] }
end

Faye::WebSocket.load_adapter('puma')

$finsync_sockets = Faye::RackAdapter.new faye_config

######################################
# Logging
######################################
$finsync_sockets.on(:handshake) do |client_id|
  puts "HANDSHAKE: #{client_id}"
end

$finsync_sockets.on(:subscribe) do |client_id, channel|
  puts "SUBSCRIBE: #{client_id}, #{channel}"
end

$finsync_sockets.on(:unsubscribe) do |client_id, channel|
  puts "UNSUBSCRIBE: #{client_id}, #{channel}"
end

$finsync_sockets.on(:publish) do |client_id, channel, data|
  puts "PUBLISH: #{client_id}, #{channel}"
end

$finsync_sockets.on(:disconnect) do |client_id|
  puts "DISCONNECT: #{client_id}"
end
