# http://api.movieclips.com/v2/videos/2MYWd
# http://api.movieclips.com/v2/search/videos?q=mark%20it%20zero

module Movieclips

  BASE = 'http://api.movieclips.com/v2/'

  def self.search(params)
    raw = HTTP.request('search/videos', params)
    s = begin
      raw[:body]['feed']['entry'].map do |i|
        link = i['link'].select{|x| x['@rel']=='self'}.first['@href'] rescue nil
        {
          id:    i['id'],
          title: i['title'],
          link:  link
        }
      end
    rescue
      []
    end
    [raw[:status], {}, s.to_json]
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
      conn = EM::HttpRequest.new(uri)#BASE + path)
      get = conn.get(query: options)
      {
        status: get.response_header.status,
        body:   parse_response(get.response)
      }
    end

    def self.parse_response(xml)
      xml.gsub!("<?xml version='1.0' encoding='utf-8'",
                '<?xml version="1.0" encoding="utf-8"')
      obj = Nori.parse(xml)
      obj
    end
  end
end

