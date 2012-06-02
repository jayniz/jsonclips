require 'goliath'
require 'em-synchrony/em-http'
require 'bundler'
require 'json'
Bundler.require
require_relative 'lib/movieclips'

class JSONClips < Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::JSONP
  use Goliath::Rack::Render, ['json']

  def response(env)
    if cached = cache_get(env)
      puts "HIT"
      return [200, {}, cached]
    end

    result = dispatch(env)
    cache_set(env, result)
    result
  end

  private

  def cache_set(env, response)
    return unless response[0].to_i == 200
    config['memcached'].set(env['REQUEST_URI'], response.last)
  end

  def cache_get(env)
    config['memcached'].get(env['REQUEST_URI'])
  end

  def dispatch(env)
    method = get_method(env)
    return _301 unless method
    puts "GET #{method} with #{params(env)}"
    return _404(env) unless Movieclips.respond_to?(method)
    result = Movieclips.send(method, env)
  end

  def params_hash(env)
    params = env['QUERY_STRING'].
               split('&').
               map{|x| x.split('=')}.
               flatten
    Hash[*params]
  end

  def _301
    github = "https://github.com/jayniz/jsonclips#readme"
    [301, {'Location' => github}, github]
  end

  def _404(env)
    [404, {}, {success: false, env: env}.to_json]
  end

  def get_method(env)
    parts = env['REQUEST_PATH'].split("/")
    method = parts[1]
  end
end
