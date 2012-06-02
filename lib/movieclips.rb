# http://api.movieclips.com/v2/videos/2MYWd
require_relative './movieclips_search.rb'
require_relative './movieclips_http.rb'

module Movieclips

  BASE = 'http://api.movieclips.com/v2/'

  def self.search(params)
    Search.search(params)
  end

  def self.sleepypants(params)
    puts "Sleep"
    sleep 5
    puts "Wakeup"
    "HOLA"
  end

end
