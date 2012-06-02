require 'bundler'
require 'json'
Bundler.require
require_relative './movieclips'

class JSONClips < Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::JSONP
  use Goliath::Rack::Render, ['json']

  def response(env)
    method = get_method(env)
    puts "GET #{method} with #{params(env)}"
    return _404(env)  unless Movieclips.respond_to?(method)
    response = Movieclips.send(method, params(env))
    [200, {}, response]
  end

  private

  def params(env)
    params = env['QUERY_STRING'].
               split('&').
               map{|x| x.split('=')}.
               flatten
    Hash[*params]
  end

  def _404(env)
    [404, {}, {success: false, env: env}.to_json]
  end

  def get_method(env)
    parts = env['REQUEST_PATH'].split("/")
    method = parts[1]
  end
end
