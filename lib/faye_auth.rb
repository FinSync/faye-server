class FayeAuth
  def incoming(message, callback)
    unless _authenticated_channel(message['channel'])
      return callback.call(message)
    end

    msg_token  = message['ext'] && message['ext']['authToken']
    auth_token = ENV['FAYE_AUTH_TOKEN'] || 'foo'

    if msg_token != auth_token
      puts "UNAUTHORIZED: #{message['channel']}"
      message['error'] = 'UNAUTHORIZED'
    end

    # Call the server back now we're done
    callback.call(message)
  end

  private

  def _authenticated_channel(channel)
    return true  if channel == '/meta/subscribe'
    return false if !!(channel =~ /meta/)
    return true
  end
end
