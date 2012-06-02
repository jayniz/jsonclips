# http://api.movieclips.com/v2/videos/2MYWd
require_relative './movieclips_search.rb'
require_relative './movieclips_video.rb'
require_relative './movieclips_http.rb'

module Movieclips

  BASE = 'http://api.movieclips.com/v2/'

  def self.search(env)
    o = { exclude_movie: env['params']['exclude_movie'] }
    Search.search(env['QUERY_STRING'], o)
  end

  def self.search_title_quote(env)
    p = env['params']
    o = { exclude_movie: "#{p['q']},mashup,top%2010}" }
    Search.search(env['QUERY_STRING']+"&count=99999", o)
  end

  def self.videos(env)
    Video.show(env['REQUEST_PATH'].split('/').last)
  end

  def self.sleepypants(params)
    puts "Sleep"
    sleep 5
    puts "Wakeup"
    "HOLA"
  end

end
