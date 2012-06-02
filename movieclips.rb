# http://api.movieclips.com/v2/videos/2MYWd
# http://api.movieclips.com/v2/search/videos?q=mark%20it%20zero

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

  private

  def self.empty
    [200, {}, '[]']
  end

end

module Movieclips
  module Search
    def self.search(params)
      raw = HTTP.request('search/videos', params)
      entries = raw[:body]['feed']['entry']
      return empty unless entries

      # When movieclips finds exactly one hit, the search
      # returns not an array, but only that hit. So yeah.
      entries = [entries].flatten
      s = entries.map{|e| parse_entry(e)}.compact
      [raw[:status], {}, s.to_json]
    end

    def self.parse_entry(e)
      {id: e['id'],
       title: e['title']
      }
    end
  end
end

module Movieclips
  module HTTP

    def self.request(path, query_string)
      uri = "#{BASE + path}?"+query_string
      puts "FORWARDING TO #{uri}"
      conn = EM::HttpRequest.new(uri)
      get = conn.get
      {
        status: get.response_header.status,
        body:   parse_response(get.response)
      }
    end

    def self.parse_response(xml)
      xml.gsub!("<?xml version='1.0' encoding='utf-8'",
                '<?xml version="1.0" encoding="utf-8"')
      obj = Nori.parse(xml)
      puts obj.to_json
      obj
    end
  end
end

