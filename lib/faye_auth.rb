class FayeAuth
  def incoming(message, callback)
    puts 'has incoming message'
    unless _authenticated_channel(message['channel'])
      puts '    but its not authenticated'
      return callback.call(message)
    end

    msg_token  = message['ext'] && message['ext']['authToken']
    auth_token = ENV['FAYE_AUTH_TOKEN'] || 'SnG94zUrWGEoYTHOHHArzw'

    if msg_token != auth_token
      puts "    message token: #{msg_token} is not equal to #{auth_token}"
      puts "    UNAUTHORIZED: #{message['channel']}"
      message['error'] = 'UNAUTHORIZED'
    end
    # Call the server back now we're done
    puts message
    callback.call(message)
  end

  private

  def _authenticated_channel(channel)
    return true  if channel == '/meta/subscribe'
    return false if !!(channel =~ /meta/)
    return true
  end
end
