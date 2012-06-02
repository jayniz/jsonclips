# http://api.movieclips.com/v2/videos/2MYWd
# http://api.movieclips.com/v2/search/videos?q=mark%20it%20zero

module Movieclips

  BASE = 'http://api.movieclips.com/v2/'

  def self.search(params)
    HTTP.request('search/videos', params)
  end

  def self.sleepypants(params)
    puts "Sleep"
    sleep 5
    puts "Wakeup"
    "HOLA"
  end


  module HTTP

    def self.request(path, options = {})
      uri = "#{BASE + path}?"+options.map{|k,v| k+'='+v}.join('&')
      puts "FORWARDING TO #{uri}"
      conn = EM::HttpRequest.new(BASE + path)
      get = conn.get(query: options)
      response = get.response
      # puts get.response_header.status
      # parse_response response
      puts "Done"
      "#{Time.now} #{response}"
    end

    def self.parse_response(xml)
      puts xml
    end
  end

end
