module FakeCache
  def self.get(*args); false; end
  def self.set(*args); false; end
end

environment :development do
  Goliath::API.use ::Rack::Reloader
  config['memcached'] = FakeCache
end

environment :production do
  config['memcached'] = Dalli::Client.new(nil, async: true)
end

