require 'faye'
require 'faye/redis'
require './lib/faye_auth'

class FayeServer

  def initialize
    faye = _faye_adapter(FayeServer.config)
    @app = Rack::Builder.new do
      run faye
    end
  end

  def call(env)
    @app.call(env)
  end

  def self.config
    @config ||= {}
  end

  private

  def _faye_adapter(config)
    @faye_adapter ||= Faye::RackAdapter.new(config).tap do |f|
      f.on(:handshake) do |client_id|
        puts "HANDSHAKE: #{client_id}"
      end

      f.on(:subscribe) do |client_id, channel|
        puts "SUBSCRIBE: #{client_id}, #{channel}"
      end

      f.on(:unsubscribe) do |client_id, channel|
        puts "UNSUBSCRIBE: #{client_id}, #{channel}"
      end

      f.on(:publish) do |client_id, channel, data|
        puts "PUBLISH: #{client_id}, #{channel}"
      end

      f.on(:disconnect) do |client_id|
        puts "DISCONNECT: #{client_id}"
      end

      f.add_extension(FayeAuth.new)
    end
  end

end
