environment :development do
  Goliath::API.use ::Rack::Reloader
  config['memcached'] =  Dalli::Client.new('localhost:11211')
end

environment :production do
  config['memcached'] = Dalli::Client.new(nil, async: true)
end

